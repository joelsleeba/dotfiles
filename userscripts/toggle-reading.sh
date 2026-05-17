#!/bin/bash

# theme=$(hyprctl getoption decoration:screen_shader | grep str | grep EMPTY)
# if [[ -z "$theme" ]]; then
# 	hyprctl keyword decoration:screen_shader "[[EMPTY]]"
# else
# 	hyprctl keyword decoration:screen_shader ~/.config/hypr/greyscaleShader.frag
# fi

theme=$(hyprshade current | grep reading_mode)
if [[ -z "$theme" ]]; then
  hyprshade on reading_mode
else
  hyprshade off
fi
