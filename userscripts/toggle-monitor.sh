#!/bin/bash

# Faulty now. hyprctl monitors does not have dpmsStatus
HDMI=$(hyprctl monitors | grep "HDMI-A-1")
if [[ -n $HDMI ]]; then
  hyprctl dispatch 'hl.dsp.dpms({ action = "toggle", monitor = "HDMI-A-1" })'
else
  hyprctl dispatch 'hl.dsp.dpms({ action = "toggle", monitor = "eDP-1" })'
fi
