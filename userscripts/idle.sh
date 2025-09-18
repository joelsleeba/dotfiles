#!/bin/bash

swayidle -w \
	timeout 180 'brightnessctl set 5% -s' resume 'brightnessctl -r' \
	timeout 240 'waylock -ignore-empty-password -fork-on-lock -init-color 0x3c3836 -input-color 0x458588 -fail-color 0xd93025' \
	timeout 300 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' \
	timeout 480 'systemctl suspend' resume 'hyprctl dispatch dpms on' \
	before-sleep 'playerctl pause'
