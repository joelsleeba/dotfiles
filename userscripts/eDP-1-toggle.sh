#!/bin/bash

# Faulty now. hyprctl monitors does not have dpmsStatus
dpmsStatus=$(hyprctl monitors | grep -A 18 "eDP-1" | grep dpmsStatus | grep 0)
if [[ -z $dpmsStatus ]]; then
	hyprctl dispatch dpms off eDP-1
else
	hyprctl dispatch dpms on eDP-1
fi
