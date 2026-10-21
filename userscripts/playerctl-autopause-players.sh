#!/bin/bash

declare -A status_by_player

# Record existing playback without pausing anything.
while read -r player status; do
  [[ -n "$player" ]] || continue
  status_by_player["$player"]="$status"
done < <(
  playerctl --all-players --ignore-player=playerctld \
    --format '{{playerName}} {{status}}' status 2>/dev/null
)

# React only to a transition into Playing.
playerctl --all-players --ignore-player=playerctld --follow \
  --format '{{playerName}} {{status}}' status |
  while read -r player status; do
    [[ -n "$player" ]] || continue

    previous=${status_by_player["$player"]:-}
    status_by_player["$player"]="$status"

    [[ "$status" == Playing && "$previous" != Playing ]] || continue

    # Check actual current statuses before pausing another player.
    while read -r other other_status; do
      [[ -n "$other" && "$other" != "$player" ]] || continue
      if [[ "$other_status" == Playing ]]; then
        playerctl --player="$other" pause
        status_by_player["$other"]=Paused
      fi
    done < <(
      playerctl --all-players --ignore-player=playerctld \
        --format '{{playerName}} {{status}}' status 2>/dev/null
    )
  done
