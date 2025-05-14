#!/bin/sh

if [[ $(ps aux | grep dunst | wc -l) -ge 2 ]]; then
	client='dunst'
elif [[ $(ps aux | grep mako | wc -l) -ge 2 ]]; then
	client='mako'
fi

if [[ "$client" == 'mako' ]]; then
	if [[ $(makoctl mode) == *"do-not-disturb"* ]]; then
		makoctl mode -r do-not-disturb
	else
		makoctl mode -a do-not-disturb
	fi
elif [[ "$client" == 'dunst' ]]; then
	# DUNST
	pause_level=59
	if $(dunstctl is-paused); then
		dunstctl set-pause-level 0
	else
		dunstctl set-pause-level $pause_level
	fi
else
	echo "specify your notification daemon"
fi

pkill -SIGRTMIN+11 waybar
