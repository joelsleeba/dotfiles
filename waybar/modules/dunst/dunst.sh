##!/bin/bash

count=$(dunstctl count waiting)

if [[ $count -eq 0 ]]; then
	count=""
fi

# Function to generate the Waybar custom module return-type format
generate_waybar_output() {
	if $(dunstctl is-paused); then
		# echo {"text": "🔕$count", "tooltip": "Do Not Disturb"}
		echo "🔕$count"
	else
		# echo {"text": "🔔", "tooltip": "Notifications On"}
		echo "🔔"
	fi
}

# Output the Waybar custom module format
generate_waybar_output
