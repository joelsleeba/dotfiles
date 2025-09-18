#!/bin/bash

# Keep track of the last playing player
current_player=""

playerctl --follow metadata --format '{{playerName}} {{status}}' | while read -r line; do
  player=$(awk '{print $1}' <<<"$line")
  status=$(awk '{print $2}' <<<"$line")

  #echo $player $status $current_player

  if [[ "$status" == "Playing" ]]; then
    if [ -n "$current_player" ] && [ "$current_player" != $player ]; then
      playerctl -p "$current_player" pause
    fi
    current_player="$player"
  fi
done
