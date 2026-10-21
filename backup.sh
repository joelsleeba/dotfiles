#!/usr/bin/env bash
# author: GPT 6.1-sol
# Copy selected XDG configs into the directory containing this script.
# Requires Bash, GNU realpath, rsync, and flock (util-linux).
# Existing files are updated; removed source files are NOT deleted from the repo.
# Symlinks are preserved, including absolute links; external targets aren't copied.
set -Eeuo pipefail

usage() {
  cat <<'HELP'
Usage: bash backup.sh [--dry-run] [--source DIR] [--dest DIR]

Defaults:
  Source:      $XDG_CONFIG_HOME or ~/.config
  Home files:  $HOME
  Destination: directory containing backup.sh

  -n, --dry-run  Show changes without writing files
  --source DIR  Use another configuration directory
  --dest DIR    Use another existing backup directory
  -h, --help    Show this help

Copies only the entries in CONFIGS and HOME_FILES below. Missing entries are skipped.
Preserves symlinks and permissions. Excludes generated data and nested duplicates.
Does not delete destination files, commit, push, or enable services.
Review git diff afterward; this is an incremental config copy, not a snapshot.
HELP
}
fail() {
  printf 'Error: %s\n' "$*" >&2
  exit 1
}
source_dir="${XDG_CONFIG_HOME:-$HOME/.config}"
dest_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
dry_run=false
while (($#)); do
  case "$1" in
  -n | --dry-run)
    dry_run=true
    shift
    ;;
  --source | --dest)
    (($# >= 2)) || fail "$1 requires a directory"
    [[ -n "$2" ]] || fail "$1 requires a nonempty directory"
    if [[ "$1" == --source ]]; then source_dir="$2"; else dest_dir="$2"; fi
    shift 2
    ;;
  -h | --help)
    usage
    exit 0
    ;;
  *) fail "Unknown argument: $1 (see --help)" ;;
  esac
done
for tool in rsync realpath flock; do
  command -v "$tool" >/dev/null || fail "Required command not found: $tool"
done
[[ -d "$source_dir" ]] || fail "Source directory does not exist: $source_dir"
[[ -d "$dest_dir" ]] || fail "Destination directory does not exist: $dest_dir"
source_dir="$(realpath -e -- "$source_dir")"
dest_dir="$(realpath -e -- "$dest_dir")"
[[ "$source_dir" != / && "$dest_dir" != / ]] || fail 'Refusing filesystem root'
[[ "$source_dir" != "$dest_dir" && "$dest_dir" != "$source_dir/"* && "$source_dir" != "$dest_dir/"* ]] ||
  fail 'Source and destination must not overlap'
# Lock the destination directory inode without adding a file to the repository.
exec {lock_fd}<"$dest_dir"
flock -n "$lock_fd" || fail 'Another backup is using this destination'

# Edit this allowlist to choose which applications are backed up.
CONFIGS=(
  bat btop dunst foot gtk-3.0 gtk-4.0 hypr kitty mimeapps.list
  mpd mpv ncmpcpp networkmanager-dmenu nvim papis rbw rmpc
  sioyek surfingkeys systemd/user tridactyl userscripts waybar
  wireplumber wofi yazi zathura
)
# Explicit home dotfiles, copied to the repo root with their leading dots.
# Add other home files here; do not use a blanket .* glob.
HOME_FILES=(
  .p10k.zsh .zprofile .zsh_plugins.txt .zshrc
)
# Patterns are relative to the source root. Keep plugin locks, snippets, themes,
# wallpapers, and MPD lyrics/playlists; omit runtime state and accidental copies.
EXCLUDES=(
  '.git/' '*.log' '*.old' '*.bak' '*.swp' '*.swo' '*~'
  '__pycache__/' '*.pyc' '.cache/'
  '/btop/btop.log' '/mpd/database' '/mpd/state' '/mpd/sticker.sql*'
  '/mpd/pid' '/mpd/socket' '/mpd/log' '/ncmpcpp/error.log'
)
args=(--archive --relative --checksum --itemize-changes --human-readable
  --no-owner --no-group --omit-dir-times --no-devices --no-specials)
$dry_run && args+=(--dry-run)
for pattern in "${EXCLUDES[@]}"; do args+=(--exclude="$pattern"); done
selected=()
for entry in "${CONFIGS[@]}"; do
  if [[ -e "$source_dir/$entry" || -L "$source_dir/$entry" ]]; then
    selected+=("./$entry")
  else
    printf 'Skip missing: %s\n' "$entry"
  fi
done
home_selected=()
for entry in "${HOME_FILES[@]}"; do
  [[ "$entry" == .* && "$entry" != */* && "$entry" != . && "$entry" != .. ]] ||
    fail "HOME_FILES entries must be dotfile basenames: $entry"
  if [[ -e "$HOME/$entry" || -L "$HOME/$entry" ]]; then
    [[ "$HOME/$entry" != "$dest_dir/$entry" ]] || fail "Home source equals destination: $entry"
    home_selected+=("./$entry")
  else
    printf 'Skip missing home file: %s\n' "$entry"
  fi
done
((${#selected[@]} + ${#home_selected[@]})) || fail 'No selected configurations found'
printf 'Source: %s\nDestination: %s\n' "$source_dir" "$dest_dir"
$dry_run && printf 'Dry run: no files will be changed.\n'
# Relative arguments preserve the systemd/user hierarchy without copying
# any system-level units. No -L: links are archived rather than traversed.
if ((${#selected[@]})); then
  (cd -- "$source_dir" && rsync "${args[@]}" -- "${selected[@]}" "$dest_dir/")
fi
if ((${#home_selected[@]})); then
  printf 'Home source: %s\n' "$HOME"
  (cd -- "$HOME" && rsync "${args[@]}" -- "${home_selected[@]}" "$dest_dir/")
fi
if $dry_run; then
  printf '\nPreview complete. Run without --dry-run to copy.\n'
else
  printf '\nBackup complete. Review changes with git diff before committing.\n'
fi
