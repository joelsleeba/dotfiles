#!/bin/bash

pause_level=60
if $(dunstctl is-paused); then
	dunstctl set-pause-level 0
else
	dunstctl set-pause-level $pause_level
fi
