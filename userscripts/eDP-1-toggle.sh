#!/bin/bash

dpmsStatus=$(hyprctl monitors | grep -A 11 "eDP-1" | grep dpmsStatus | grep 0)
if [[ -z $dpmsStatus ]]; then
	hyprctl dispatch dpms off eDP-1
else
	hyprctl dispatch dpms on eDP-1
fi
