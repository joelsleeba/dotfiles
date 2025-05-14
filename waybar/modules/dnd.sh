##!/bin/bash

client="dunst"

if [[ $(ps -e | grep mako) ]]; then
	client="mako"
elif [[ $(ps -e | grep dunst) ]]; then
	client="dunst"
fi

# Function to generatv the Waybar custom module return-type format
generate_waybar_output() {
	# if Mako or Dunst
	if [[ "$client" == "dunst" ]]; then
		if $(dunstctl is-paused); then
			if [[ $(dunstctl count waiting) -ne 0 ]]; then
				count=$(dunstctl count waiting)
			else
				count=''
			fi
			echo "🔕$count"
			# echo "{'text': '🔕$count', 'tooltip': 'Notifications Off'}"
		else
			# echo {"text": "🔔", "tooltip": "Notifications On"}
			echo "🔔"
		fi
	elif [[ "$client" == "mako" ]]; then
		echo "why are u here"
		if [[ $(makoctl mode) == *"do-not-disturb"* ]]; then
			# echo {"text": "🔕", "tooltip": "Notifications Off"}
			echo "🔕"
		else
			echo "🔔"
		fi
	else
		echo "specify your notification daemon"
	fi
}

# Output the Waybar custom module format
generate_waybar_output
