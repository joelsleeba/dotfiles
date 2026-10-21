#!/usr/bin/env bash

# State file remembers the last alert level sent so the timer doesn't
# re-send the same notification on every run.
state_file="/tmp/battery.state"

battery_20=(
  "The vibes have shifted."
  "I have a bad feeling about this."
  "We should probably start thinking about a charger."
  "The Fellowship has left Rivendell."
  "The first horseman has arrived."
  "Everything is fine. Probably."
  "This is your courtesy warning before the plot thickens."
  "Somewhere nearby, a wall outlet is waiting."
  "The age of abundance is ending."
  "The machine has begun glancing nervously at the charger."
  "This is where the ominous soundtrack starts."
  "You still have time to make several poor decisions."
  "Houston, we have a mildly inconvenient problem."
  "We are entering the second act."
  "The battery would like to schedule a meeting."
  "Winter is coming."
  "A disturbance has been detected in the Force."
  "This would be a good moment to remember where you left the charger."
  "No panic. Just foreshadowing."
  "The plot has officially acquired stakes."
)

battery_10=(
  "I am once again asking for electricity."
  "This is no longer a side quest."
  "The charger is now part of the main storyline."
  "You shall not pass... much longer."
  "Things are getting a little Mad Max in here."
  "We have entered the consequences phase."
  "The reactor core is beginning to look decorative."
  "This is the part where someone says 'we have a problem.'"
  "The margin for nonsense is narrowing."
  "Please begin negotiations with a wall socket."
  "The situation has upgraded from quirky to operational."
  "Bold strategy, continuing like this."
  "The machine is becoming aware of mortality."
  "The clock is ticking, Jack Bauer."
  "At this point, plugging in would count as character development."
  "The battery has stopped being polite."
  "We are officially rationing electrons."
  "This feels like the scene before the red lights start flashing."
  "The charger has been promoted from accessory to necessity."
  "The ship is still flying. Barely."
)

battery_7=(
  "Strange number. Bad energy."
  "We are now operating mostly on spite."
  "This has become unnecessarily dramatic."
  "The machine would like to formally request power."
  "This is not a sustainable lifestyle."
  "You are testing the limits of lithium chemistry."
  "The engines cannae take much more, Captain."
  "Every electron is now unionized."
  "This has become performance art."
  "The laptop is surviving out of professional pride."
  "You are entering the 'well, this is awkward' portion of the evening."
  "There is still time to make one respectable decision."
  "We are approaching Apollo 13 levels of improvisation."
  "The charger situation is becoming embarrassing."
  "The battery is beginning to resent you personally."
  "This is less Iron Man and more 'arc reactor failing.'"
  "The remaining electrons are requesting hazard pay."
  "The machine is holding on like Boromir."
  "We have entered the stupid zone."
  "At this point, optimism is doing most of the work."
)

battery_5=(
  "This is now a hostage situation."
  "The laptop has begun writing its will."
  "We had so many chances."
  "The end credits are warming up."
  "This machine is being kept alive by bureaucracy."
  "You have chosen violence."
  "The remaining electrons have families."
  "The reactor core is making concerning noises."
  "This is your last chance to look competent."
  "I hope whatever you're doing is worth becoming a cautionary tale."
  "The laptop has accepted its fate."
  "If this dies now, I want the record to show I tried."
  "We are running on fumes, denial, and one heroic capacitor."
  "This is the scene where the lights start flickering."
  "Save your work. The prophecy is nearly fulfilled."
  "The machine is one dramatic piano chord from collapse."
  "The charger is now a medical device."
  "This is no longer a warning. It is lore."
  "Tell my browser tabs I loved them."
  "So this is how liberty dies. With thunderous battery drain."
)

battery_100=(
  "Electrical abundance has been restored."
  "Civilization survives another day."
  "We are rich in electrons."
  "The charger has completed its sacred duty."
  "The age of scarcity is over."
  "The machine is feeling suspiciously invincible."
  "Maximum power. Maximum hubris."
  "The reactor is fully operational."
  "You may now wander freely."
  "The electrons have assembled."
  "Everything is under control, for once."
  "The battery has reached enlightenment."
  "This is what peak civilization looks like."
  "The arc reactor is online."
  "Fully armed and operational."
  "Unlimited power!"
  "The machine has achieved its final form."
  "All systems nominal. Go cause problems."
  "Power reserves are now irresponsibly healthy."
  "The ship is ready, Captain."
)

random_message() {
  local array_name="$1"
  local -n messages="$array_name"

  printf '%s\n' "${messages[RANDOM % ${#messages[@]}]}"
}

# Parse acpi output and keep the lowest capacity across all batteries.
# Example:
#   Battery 0: Discharging, 47%, 02:23:38 remaining
read -r status capacity < <(
  acpi -b 2>/dev/null | awk -F'[,:%]' '
    /Battery/ {
      s = $2
      gsub(/^[ \t]+|[ \t]+$/, "", s)

      c = $3 + 0

      if (min == "" || c < min) {
        min = c
        status = s
      }
    }

    END {
      if (min != "")
        print status, min
    }
  '
)

# Bail out if we have no usable battery data.
[[ -n "${status}" && "${capacity}" =~ ^[0-9]+$ ]] || exit 0

active=$(cat "${state_file}" 2>/dev/null)

mkdir -p "$(dirname "${state_file}")"

if [[ "${status}" == Discharging ]]; then

  # Determine the most severe threshold we've reached.
  if ((capacity <= 5)); then
    level=5
  elif ((capacity <= 7)); then
    level=7
  elif ((capacity <= 10)); then
    level=10
  elif ((capacity <= 20)); then
    level=20
  else
    level=""
  fi

  if [[ -n "${level}" && "${active}" != "${level}" ]]; then
    case "${level}" in
    20)
      message=$(random_message battery_20)
      ;;
    10)
      message=$(random_message battery_10)
      ;;
    7)
      message=$(random_message battery_7)
      ;;
    5)
      message=$(random_message battery_5)
      ;;
    esac

    notify-send \
      -t 300000 \
      -u critical \
      -c battery-low \
      "Battery: ${capacity}%" \
      "${message}"

    echo "${level}" >"${state_file}"
  fi

  # Once we're above 20%, reset everything so 20% can fire again later.
  if ((capacity > 20)); then
    rm -f "${state_file}"
  fi

elif [[ ("${status}" == Charging || "${status}" == Full) && "${capacity}" -eq 100 ]]; then

  if [[ "${active}" != full ]]; then
    message=$(random_message battery_5)
    notify-send \
      -t 300000 \
      -u normal \
      -c battery-full \
      "Battery Full" \
      "${message}"

    echo full >"${state_file}"
  fi

else
  # Charging but not full: clear previous low-battery state.
  #
  # This means unplugging again later can trigger the appropriate
  # warning afresh.
  rm -f "${state_file}"
fi
