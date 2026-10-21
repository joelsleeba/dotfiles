#!/bin/bash
#Author: Joel Sleeba

save_dir=$HOME/Pictures/Screenshots

mode_options="Selection
Active Window
Active Monitor"

output_options="Clipboard
/tmp
Save"

mode=$(echo "$mode_options" | wofi -d --hide-scroll --allow-markup --prompt='Screenshot Mode')
output=$(echo "$output_options" | wofi -d --hide-scroll --allow-markup --prompt='Screenshot Output')

echo $mode
echo $output

# sleep 1

if [[ "$mode" == "Selection" ]]; then
  if [[ "$output" == "Clipboard" ]]; then
    grim -g "$(slurp)" - | wl-copy -t image
  elif [[ "$output" == "/tmp" ]]; then
    grim -g "$(slurp)" "/tmp/$(date +%Y.%m.%d-%H%M%S).jpg"
  else
    grim -g "$(slurp)" "$save_dir/$(date +%Y.%m.%d-%H%M%S).jpg"
  fi
elif [[ "$mode" == "Active Window" ]]; then
  if [[ "$output" == "Clipboard" ]]; then
    grim -g "$(hyprctl activewindow -j | jq -c -r '.at,.size | .[]' | tr '\n' ' ' | sed 's/ /,/1' | sed 's/ /x/2' | sed 's/ /\n/2')" - | wl-copy -t image/png
  elif [[ "$output" == "/tmp" ]]; then
    grim -g "$(hyprctl activewindow -j | jq -c -r '.at,.size | .[]' | tr '\n' ' ' | sed 's/ /,/1' | sed 's/ /x/2' | sed 's/ /\n/2')" "/tmp/$(date +%Y.%m.%d-%H%M%S).jpg"
  else
    grim -g "$(hyprctl activewindow -j | jq -c -r '.at,.size | .[]' | tr '\n' ' ' | sed 's/ /,/1' | sed 's/ /x/2' | sed 's/ /\n/2')" "$save_dir/$(date +%Y.%m.%d-%H%M%S).jpg"
  fi
else
  if [[ "$output" == "Clipboard" ]]; then
    grim -o $(hyprctl monitors -j | jq -r '.[] | select(.focused)| .name') - | wl-copy -t image
  elif [[ "$output" == "/tmp" ]]; then
    grim -o $(hyprctl monitors -j | jq -r '.[] | select(.focused)| .name') "/tmp/$(date +%Y.%m.%d-%H%M%S).jpg"
  else
    grim -o $(hyprctl monitors -j | jq -r '.[] | select(.focused)| .name') "$save_dir/$(date +%Y.%m.%d-%H%M%S).jpg"
  fi
fi
