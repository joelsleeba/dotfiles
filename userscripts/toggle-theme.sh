#!/bin/bash

theme=$(cat /tmp/color_scheme)
if [[ $theme == "night" ]]; then
	bash $HOME/.config/userscripts/day.sh
else
	bash $HOME/.config/userscripts/night.sh
fi
