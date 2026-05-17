#!/usr/bin/env bash
#Author: Joel Sleeba

save_dir="$HOME/Pictures/Screenshots"
mkdir -p "$save_dir"

mode_options="Selection
Active Window
Active Monitor"

output_options="Clipboard
/tmp
Save"

mode=$(printf "%s\n" "$mode_options" |
  wofi --insensitive --dmenu --hide-scroll --prompt='Screenshot Mode' |
  tr -d '\r' | sed 's/[[:space:]]*$//')

output=$(printf "%s\n" "$output_options" |
  wofi -d --hide-scroll --prompt='Screenshot Output' |
  tr -d '\r' | sed 's/[[:space:]]*$//')

echo "$mode"
echo "$output"
echo "$mode" | od -An -tx1
echo "$output" | od -An -tx1

timestamp="$(date +%Y.%m.%d-%H%M%S)"
tmp_file="/tmp/$timestamp.png"
save_file="$save_dir/$timestamp.png"

copy_cmd='wl-copy -t image/png'

get_active_window_geom() {
  hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"'
}

get_active_monitor() {
  hyprctl monitors -j | jq -r '.[] | select(.focused) | .name'
}

case "$mode" in
Selection)
  geom="$(slurp -d)" || exit 1
  ;;
"Active Window")
  geom="$(get_active_window_geom)" || exit 1
  ;;
"Active Monitor")
  monitor="$(get_active_monitor)" || exit 1
  ;;
esac

case "$output" in
Clipboard)
  if [ "$mode" = "Active Monitor" ]; then
    grim -o "$monitor" - | $copy_cmd
  else
    grim -g "$geom" - | $copy_cmd
  fi
  ;;
/tmp)
  if [ "$mode" = "Active Monitor" ]; then
    grim -o "$monitor" "$tmp_file"
  else
    grim -g "$geom" "$tmp_file"
  fi
  ;;
Save)
  if [ "$mode" = "Active Monitor" ]; then
    grim -o "$monitor" "$save_file"
  else
    grim -g "$geom" "$save_file"
  fi
  ;;
esac
