#!/bin/bash

swayidle -w \
	timeout 180 'brightnessctl set 5% -s' resume 'brightnessctl -r' \
	timeout 240 'waylock -ignore-empty-password -fork-on-lock' \
	timeout 300 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' \
	timeout 480 'systemctl suspend' resume 'hyprctl dispatch dpms on' \
	before-sleep 'playerctl pause'
