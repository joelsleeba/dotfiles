#!/usr/bin/env bash
set -euo pipefail

for command in sp rofi jq; do
  command -v "$command" >/dev/null || {
    echo "Missing command: $command" >&2
    exit 1
  }
done

cache_dir="/tmp/sp-today-rofi"
cache_file="$cache_dir/$(date +%F).json"
mkdir -p "$cache_dir"

refresh() {
  local open_json done_json tmp
  open_json=$(sp --dropbox task list --today --json) || return 1
  done_json=$(sp --dropbox task list --today --done --json) || return 1
  tmp=$(mktemp "$cache_dir/.tasks.XXXXXX")
  if ! jq -n --argjson open "$open_json" --argjson done "$done_json" '
    [($open[] | select(.id != null) | {id, title, done: false}),
     ($done[] | select(.id != null) | {id, title, done: true})]
    | unique_by(.id)
  ' >"$tmp"; then
    rm -f "$tmp"
    return 1
  fi
  mv -f "$tmp" "$cache_file"
}

if [[ ! -s "$cache_file" ]]; then
  refresh || {
    echo "Dropbox task fetch failed. Run 'sp login' and enable Dropbox sync." >&2
    exit 1
  }
fi

while :; do
  rows=$(jq -r '.[] | [.id, ((if .done then "✓  " else "○  " end) + (.title // "(untitled)" | gsub("[\r\n\t]"; " "))), (.done | tostring)] | @tsv' "$cache_file")
  ids=() states=() labels=()
  while IFS=$'\t' read -r id label state; do
    [[ -n "$id" ]] || continue
    ids+=("$id") labels+=("$label") states+=("$state")
  done <<<"$rows"

  choices=("${labels[@]}")
  ((${#ids[@]})) || choices=('No tasks for today — Alt+r to refresh')
  set +e
  choice=$(printf '%s\n' "${choices[@]}" | rofi -dmenu -no-custom -i \
    -p 'Today' -mesg 'Enter: toggle   Alt+d: done   Alt+u: undo   Alt+r: refresh   Esc: close' \
    -kb-custom-1 'Alt+d' -kb-custom-2 'Alt+u' -kb-custom-3 'Alt+r' -format i)
  status=$?
  set -e

  case "$status" in
  12)
    refresh || rofi -e 'Dropbox refresh failed'
    continue
    ;;
  0 | 10 | 11) ;;
  1) exit 0 ;;
  *)
    echo "rofi failed (exit $status)" >&2
    exit "$status"
    ;;
  esac
  [[ "$choice" =~ ^[0-9]+$ ]] && ((choice < ${#ids[@]})) || continue

  case "$status" in
  10)
    [[ "${states[choice]}" == false ]] || continue
    new_state=true
    action=--done
    ;;
  11)
    [[ "${states[choice]}" == true ]] || continue
    new_state=false
    action=--undone
    ;;
  0) if [[ "${states[choice]}" == true ]]; then
    new_state=false
    action=--undone
  else
    new_state=true
    action=--done
  fi ;;
  esac

  # Dropbox mode is read-only; the local API performs the mutation.
  if ! sp --api task update "${ids[choice]}" "$action" >/dev/null; then
    rofi -e 'Update failed. Start the desktop app and enable its local REST API.'
    continue
  fi
  tmp=$(mktemp "$cache_dir/.tasks.XXXXXX")
  if jq --arg id "${ids[choice]}" --argjson done "$new_state" \
    'map(if .id == $id then .done = $done else . end)' "$cache_file" >"$tmp"; then
    mv -f "$tmp" "$cache_file"
  else
    rm -f "$tmp"
    exit 1
  fi
done
