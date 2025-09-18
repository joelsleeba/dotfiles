#!/bin/sh

threshold=20 # threshold percentage to trigger alert

# Use `awk` to capture `acpi`'s percent capacity ($2) and status ($3) fields
# and read their values into the `status` and `capacity` variables
acpi -b | awk -F'[,:%]' '{print $2, $3}' | {
  read -r status capacity

  # If battery is discharging with capacity below threshold
  if [ "${status}" = Discharging -a "${capacity}" -lt ${threshold} ]; then
    # Send a notification that appears for 300000 ms (5 min)
    notify-send -t 300000 -u critical -c battery-low "Low Battery"
  elif [ "${status}" = Charging -a "${capacity}" == 100 ]; then
    notify-send -t 300000 -u critical -c battery-full "Battery Full"
  fi
}
