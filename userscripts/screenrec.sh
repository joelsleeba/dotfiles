#!/bin/bash
#Author: Joel Sleeba

save_dir=$HOME/Pictures/Screengrabs

mode_options="Selection
Active Window
Active Monitor"

output_options="Clipboard
/tmp
Save"

mode=$(echo "$mode_options" | wofi -d --hide-scroll --allow-markup --prompt='Screengrab Mode') && output=$(echo "$output_options" | wofi -d --hide-scroll --allow-markup --prompt='Screengrab Output')

sleep 1

if [[ "$mode" == "Selection" ]]; then
	if [[ "$output" == "Clipboard" ]]; then
		wl-screenrec -g "$(slurp)" - | wl-copy
	elif [[ "$output" == '/tmp' ]]; then
		wl-screenrec -g "$(slurp)" "/tmp/$(date +%Y.%m.%d-%H%M%S).mp4"
	else
		wl-screenrec -g "$(slurp)" "$save_dir/$(date +%Y.%m.%d-%H%M%S).mp4"
	fi
elif [[ "$mode" == "Active Window" ]]; then
	if [[ "$output" == "Clipboard" ]]; then
		wl-screenrec -g "$(hyprctl activewindow -j | jq -c -r '.at,.size | .[]' | tr '\n' ' ' | sed 's/ /,/1' | sed 's/ /x/2' | sed 's/ /\n/2')" - | wl-copy
	elif [[ "$output" == '/tmp' ]]; then
		wl-screenrec -g "$(hyprctl activewindow -j | jq -c -r '.at,.size | .[]' | tr '\n' ' ' | sed 's/ /,/1' | sed 's/ /x/2' | sed 's/ /\n/2')" "/tmp/$(date +%Y.%m.%d-%H%M%S).mp4"
	else
		wl-screenrec -g "$(hyprctl activewindow -j | jq -c -r '.at,.size | .[]' | tr '\n' ' ' | sed 's/ /,/1' | sed 's/ /x/2' | sed 's/ /\n/2')" "$save_dir/$(date +%Y.%m.%d-%H%M%S).mp4"
	fi
else
	if [[ "$output" == "Clipboard" ]]; then
		wl-screenrec -o $(hyprctl monitors -j | jq -r '.[] | select(.focused)| .name') - | wl-copy
	elif [[ "$output" == '/tmp' ]]; then
		wl-screenrec -o $(hyprctl monitors -j | jq -r '.[] | select(.focused)| .name') "/tmp/$(date +%Y.%m.%d-%H%M%S).mp4"
	else
		wl-screenrec -o $(hyprctl monitors -j | jq -r '.[] | select(.focused)| .name') "$save_dir/$(date +%Y.%m.%d-%H%M%S).mp4"
	fi
fi
