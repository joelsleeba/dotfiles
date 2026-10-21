#!/usr/bin/env bash

# Read full paths, most recently opened first.
mapfile -t history < <(
  sqlite3 "$HOME/.local/share/zathura/bookmarks.sqlite" \
    "SELECT file FROM fileinfo WHERE file NOT LIKE '/tmp/%' ORDER BY time DESC;"
)

# Build matching arrays of full paths and display names.
paths=()
names=()

for file in "${history[@]}"; do
  if [[ -f "$file" ]]; then
    paths+=("$file")
    names+=("${file##*/}")
  fi
done

# Exit if no existing documents were found.
((${#paths[@]})) || exit 0

# Display filenames and return the selected row's index.
selected=$(
  printf '%s\n' "${names[@]}" |
    rofi -dmenu -no-custom -format i -i -p 'Open Document'
) || exit 0

[[ "$selected" =~ ^[0-9]+$ ]] || exit 0

# Open the corresponding full path.
file="${paths[$selected]}"
[[ -f "$file" ]] && exec zathura "$file"
