#!/bin/bash

# Keep track of the last playing player
initialized=false
current_player=""

playerctl --follow status --format '{{playerName}} {{status}}' |
  while read -r player status; do
    if [[ "$status" == "Playing" ]]; then
      if ! $initialized; then
        current_player="$player"
        initialized=true
        continue
      fi

      if [[ "$current_player" != "$player" ]]; then
        playerctl -p "$current_player" pause
        current_player="$player"
      fi
    fi
  done
