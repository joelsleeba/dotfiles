#!/usr/bin/bash

day_start=7
night_start=17

if [[ $day_start -le 10#$(date +%H) ]] && [[ 10#$(date +%H) -lt $night_start ]]; then
	bash $HOME/.config/userscripts/day.sh
else
	bash $HOME/.config/userscripts/night.sh
fi
