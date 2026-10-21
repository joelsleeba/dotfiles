#!/usr/bin/env bash
# Restore the selected repo configs; keep a copy of overwritten files.
# Requires Bash, rsync, GNU realpath, flock, and mktemp.
set -Eeuo pipefail
fail() {
  printf 'Error: %s\n' "$*" >&2
  exit 1
}
usage() {
  cat <<'HELP'
Usage: bash restore.sh [--dry-run] [--source REPO]

Restores CONFIGS into $XDG_CONFIG_HOME (default ~/.config), and HOME_FILES
into $HOME. The default source is the directory containing this script.
Missing repo entries are skipped. Unrelated destination files are retained.
Symlinks are preserved verbatim; external targets are not bundled or rewritten.

  -n, --dry-run  Preview changes without writing anything
  --source DIR  Restore from another existing repo directory
  -h, --help    Show help

Overwritten files are saved beneath:
  ${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles-restore/<unique timestamp>/
    config/  Files previously in your configuration directory
    home/    Files previously in your home directory

No applications are installed or services enabled. Reload apps after restoring.
HELP
}
repo="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
dry_run=false
while (($#)); do
  case "$1" in
  -n | --dry-run)
    dry_run=true
    shift
    ;;
  --source)
    (($# >= 2)) && [[ -n "$2" ]] || fail '--source requires a directory'
    repo="$2"
    shift 2
    ;;
  -h | --help)
    usage
    exit 0
    ;;
  *) fail "Unknown argument: $1 (see --help)" ;;
  esac
done
for tool in rsync realpath flock mktemp; do
  command -v "$tool" >/dev/null || fail "Required command not found: $tool"
done
[[ -d "$repo" && -d "$HOME" ]] || fail 'Repository and home directory must exist'
repo="$(realpath -e -- "$repo")"
home_dir="$(realpath -e -- "$HOME")"
config_dir="$(realpath -m -- "${XDG_CONFIG_HOME:-$HOME/.config}")"
state_dir="$(realpath -m -- "${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles-restore")"
[[ "$repo" != / && "$config_dir" != / && "$home_dir" != / ]] || fail 'Refusing filesystem root'
[[ "$repo" != "$config_dir" && "$repo" != "$config_dir/"* && "$config_dir" != "$repo/"* ]] ||
  fail 'Repository and configuration destination must not overlap'
[[ "$repo" != "$home_dir" && "$home_dir" != "$repo/"* ]] ||
  fail 'Repository must not be the home directory or its ancestor'
[[ "$state_dir" != "$repo" && "$state_dir" != "$repo/"* && "$state_dir" != "$config_dir" && "$state_dir" != "$config_dir/"* ]] ||
  fail 'Restore backups must be outside the repository and configuration directory'
# Lock the home directory inode, without creating a lock file.
exec {lock_fd}<"$home_dir"
flock -n "$lock_fd" || fail 'Another restore is using this home directory'

# Same selection and exclusions as backup.sh. Keep these lists in sync.
CONFIGS=(
  bat btop dunst foot gtk-3.0 gtk-4.0 hypr kitty mimeapps.list
  mpd mpv ncmpcpp networkmanager-dmenu nvim papis rbw rmpc
  sioyek surfingkeys systemd/user tridactyl userscripts waybar
  wireplumber wofi yazi zathura
)
HOME_FILES=(
  .p10k.zsh .zprofile .zsh_plugins.txt .zshrc
)
EXCLUDES=(
  '.git/' '*.log' '*.old' '*.bak' '*.swp' '*.swo' '*~'
  '__pycache__/' '*.pyc' '.cache/'
  '/btop/btop.log' '/mpd/database' '/mpd/state' '/mpd/sticker.sql*'
  '/mpd/pid' '/mpd/socket' '/mpd/log' '/ncmpcpp/error.log'
)

configs=()
for entry in "${CONFIGS[@]}"; do
  if [[ -e "$repo/$entry" || -L "$repo/$entry" ]]; then
    configs+=("./$entry")
  else
    printf 'Skip missing config: %s\n' "$entry"
  fi
done
home_files=()
for entry in "${HOME_FILES[@]}"; do
  [[ "$entry" == .* && "$entry" != */* && "$entry" != . && "$entry" != .. ]] ||
    fail "HOME_FILES entries must be dotfile basenames: $entry"
  if [[ -e "$repo/$entry" || -L "$repo/$entry" ]]; then
    home_files+=("./$entry")
  else
    printf 'Skip missing home file: %s\n' "$entry"
  fi
done
((${#configs[@]} + ${#home_files[@]})) || fail 'No selected configurations found'
args=(--archive --relative --checksum --itemize-changes --human-readable
  --no-owner --no-group --omit-dir-times --no-devices --no-specials)
for pattern in "${EXCLUDES[@]}"; do args+=(--exclude="$pattern"); done
printf 'Repository: %s\nConfig destination: %s\nHome destination: %s\n' "$repo" "$config_dir" "$home_dir"
if $dry_run; then
  args+=(--dry-run)
  printf 'Dry run: no files will be changed.\n'
else
  mkdir -p -- "$state_dir"
  recovery="$(mktemp -d "$state_dir/$(date +%Y%m%d-%H%M%S).XXXXXX")"
  chmod 700 -- "$recovery"
  printf 'Overwritten files will be saved in: %s\n' "$recovery"
  trap 'printf "Restore interrupted or failed; recovery files are in: %s\n" "$recovery" >&2' ERR
  mkdir -p -- "$config_dir"
fi
if ((${#configs[@]})); then
  config_args=("${args[@]}")
  if ! $dry_run; then config_args+=(--backup --backup-dir="$recovery/config"); fi
  (cd -- "$repo" && rsync "${config_args[@]}" -- "${configs[@]}" "$config_dir/")
fi
if ((${#home_files[@]})); then
  home_args=("${args[@]}")
  if ! $dry_run; then home_args+=(--backup --backup-dir="$recovery/home"); fi
  (cd -- "$repo" && rsync "${home_args[@]}" -- "${home_files[@]}" "$home_dir/")
fi
if $dry_run; then
  printf '\nPreview complete. Run without --dry-run to restore.\n'
else
  printf '\nRestore complete. Previous versions of overwritten files: %s\n' "$recovery"
fi
