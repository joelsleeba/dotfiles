#!/usr/bin/env bash
set -u

TEMP_DROP_THRESHOLD=8  # Fahrenheit, downward forecast revision
RAIN_PROB_JUMP=40      # Percentage points
RAIN_PROB_ALERT=60     # Percent in the SAME hour as the jump
RAIN_AMOUNT_JUMP=4     # Millimeters, remaining day
TOMORROW_RAIN_PROB=70  # Percent
TOMORROW_RAIN_AMOUNT=8 # Millimeters
TOMORROW_TEMP_SWING=15 # Fahrenheit
NOTIFY_TIMEOUT=180000  # Milliseconds

# Golden hour
GOLDEN_LEAD_MIN=50      # Alert when sunset is at most this many minutes away
GOLDEN_MIN_LEFT=10      # ...but not if less than this is left
GOLDEN_MAX_CLOUD=75     # Percent cloud cover at sunset; above this, skip
GOLDEN_MAX_RAIN_PROB=40 # Percent rain probability at sunset; at/above this, skip
GOLDEN_CACHE_MIN=30     # Reuse cached forecast for this many minutes in golden mode

for command in curl jq notify-send date mktemp find; do
  command -v "$command" >/dev/null 2>&1 || {
    printf 'Missing dependency: %s\n' "$command" >&2
    exit 1
  }
done

state_dir="/tmp/weather"
cache_dir="/tmp/weather"
mkdir -p "$state_dir" "$cache_dir" || exit 1
location_cache="$cache_dir/location.json"
weather_cache="$cache_dir/weather.json"

LAT=""
LON=""
CITY=""
FORECAST_TIMEZONE=""
WEATHER_JSON=""

save_state() {
  local target="$1" content="$2" temp_file
  temp_file=$(mktemp "${target}.XXXXXX") || return 1
  if ! printf '%s\n' "$content" >"$temp_file" || ! mv -f "$temp_file" "$target"; then
    rm -f "$temp_file"
    return 1
  fi
}

get_location() {
  local location_json="" raw entry url filter valid
  valid='(.latitude | type == "number") and (.longitude | type == "number")'

  # Fresh cache (24h)
  if [[ -f "$location_cache" ]] &&
    [[ -n "$(find "$location_cache" -mmin -1440 -print -quit 2>/dev/null)" ]]; then
    location_json=$(cat "$location_cache")
  fi

  if ! jq -e "$valid" >/dev/null 2>&1 <<<"$location_json"; then
    location_json=""
    # "url|jq filter that normalizes to {latitude, longitude, city}"
    local providers=(
      'https://ipwho.is/|{latitude: .latitude, longitude: .longitude, city: .city}'
      'https://ipinfo.io/json|(.loc | split(",")) as $l | {latitude: ($l[0] | tonumber), longitude: ($l[1] | tonumber), city: .city}'
      'http://ip-api.com/json/|{latitude: .lat, longitude: .lon, city: .city}'
      'https://ipapi.co/json/|{latitude: .latitude, longitude: .longitude, city: .city}'
    )
    for entry in "${providers[@]}"; do
      url=${entry%%|*}
      filter=${entry#*|}
      raw=$(curl -fsSL --retry 0 --connect-timeout 5 --max-time 10 "$url" 2>/dev/null) || continue
      raw=$(jq -c "$filter" <<<"$raw" 2>/dev/null) || continue
      if jq -e "$valid" >/dev/null 2>&1 <<<"$raw"; then
        location_json="$raw"
        save_state "$location_cache" "$location_json" || true
        break
      fi
    done
  fi

  # Last resort: stale cache is better than no forecast
  if [[ -z "$location_json" && -f "$location_cache" ]]; then
    location_json=$(cat "$location_cache")
    jq -e "$valid" >/dev/null 2>&1 <<<"$location_json" || return 1
  fi
  [[ -n "$location_json" ]] || return 1

  LAT=$(jq -r '.latitude' <<<"$location_json")
  LON=$(jq -r '.longitude' <<<"$location_json")
  CITY=$(jq -r '.city // ""' <<<"$location_json")
  [[ -n "$CITY" ]] || CITY="Weather"
}

valid_weather() {
  jq -e '.hourly.time and .hourly.temperature_2m and .hourly.precipitation_probability
    and .hourly.precipitation and .hourly.cloud_cover
    and .daily.time and .daily.sunset
    and (.timezone | type == "string")' >/dev/null 2>&1 <<<"$1"
}

# Usage: fetch_weather [max_cache_age_minutes]  (0 = always fetch fresh)
fetch_weather() {
  local max_age="${1:-0}"
  get_location || return 1
  WEATHER_JSON=""
  if ((max_age > 0)) && [[ -f "$weather_cache" ]] &&
    [[ -n "$(find "$weather_cache" -mmin "-$max_age" -print -quit 2>/dev/null)" ]]; then
    WEATHER_JSON=$(cat "$weather_cache")
  fi
  if ! valid_weather "$WEATHER_JSON"; then
    WEATHER_JSON=$(curl -fsSL --retry 2 --connect-timeout 10 --max-time 30 \
      --get 'https://api.open-meteo.com/v1/forecast' \
      --data-urlencode "latitude=$LAT" --data-urlencode "longitude=$LON" \
      --data-urlencode 'hourly=temperature_2m,precipitation_probability,precipitation,cloud_cover' \
      --data-urlencode 'daily=sunrise,sunset' \
      --data-urlencode 'temperature_unit=fahrenheit' \
      --data-urlencode 'timezone=auto' --data-urlencode 'forecast_days=3') || return 1
    valid_weather "$WEATHER_JSON" || return 1
    save_state "$weather_cache" "$WEATHER_JSON" || true
  fi
  FORECAST_TIMEZONE=$(jq -r '.timezone' <<<"$WEATHER_JSON")
  TZ="$FORECAST_TIMEZONE" date +%F >/dev/null 2>&1 || return 1
}

notify_weather() {
  notify-send -t "$NOTIFY_TIMEOUT" -u "$1" -c weather-reminder "$CITY" "$2"
}

check_today() {
  local today hour current old state comparison rain_alert rain_increase temp_drop
  fetch_weather || {
    echo 'Could not fetch location and weather data.' >&2
    return 1
  }
  today=$(TZ="$FORECAST_TIMEZONE" date +%F)
  hour=$(TZ="$FORECAST_TIMEZONE" date +%H)
  state="$state_dir/today-${today}.json"
  current=$(jq -c --arg day "$today" --argjson hour "$((10#$hour))" '
    [.hourly as $h | range(0; $h.time | length) as $i
      | select($h.time[$i][0:10] == $day and ($h.time[$i][11:13] | tonumber) >= $hour)
      | {time: $h.time[$i], temp: $h.temperature_2m[$i],
         rain_prob: $h.precipitation_probability[$i], rain: $h.precipitation[$i]}
      | select(.temp != null and .rain_prob != null and .rain != null)]' \
    <<<"$WEATHER_JSON") || return 1
  [[ "$(jq 'length' <<<"$current")" -gt 0 ]] || return 0
  if [[ ! -f "$state" ]] || ! jq -e 'type == "array"' "$state" >/dev/null 2>&1; then
    save_state "$state" "$current"
    return
  fi
  old=$(cat "$state")
  comparison=$(jq -cn --argjson old "$old" --argjson new "$current" '
    [$new[] as $n | $old[] | select(.time == $n.time)
      | {old_temp: .temp, new_temp: $n.temp, old_prob: .rain_prob,
         new_prob: $n.rain_prob, old_rain: .rain, new_rain: $n.rain}]') || return 1
  if [[ "$(jq 'length' <<<"$comparison")" -eq 0 ]]; then
    save_state "$state" "$current"
    return
  fi
  rain_alert=$(jq -c --argjson jump "$RAIN_PROB_JUMP" --argjson level "$RAIN_PROB_ALERT" '
    [.[] | select(.new_prob - .old_prob >= $jump and .new_prob >= $level)
      | {jump: (.new_prob - .old_prob), prob: .new_prob}] | max_by(.jump) // null' \
    <<<"$comparison") || return 1
  rain_increase=$(jq '[.[].new_rain] | add // 0' <<<"$comparison")
  rain_increase=$(jq -n --argjson new "$rain_increase" \
    --argjson old "$(jq '[.[].old_rain] | add // 0' <<<"$comparison")" '$new - $old')
  temp_drop=$(jq '[.[] | .old_temp - .new_temp] | max // 0' <<<"$comparison")

  if [[ "$rain_alert" != null ]]; then
    notify_weather critical "Rain is likely later today: $(jq -r '.prob' <<<"$rain_alert")%. Increase: $(jq -r '.jump' <<<"$rain_alert")%<br/>Consider taking an umbrella."
  elif jq -en --argjson value "$rain_increase" --argjson limit "$RAIN_AMOUNT_JUMP" '$value >= $limit' >/dev/null; then
    notify_weather critical "Expected rainfall for the rest of today increased by ${rain_increase}mm.<br/>Consider taking an umbrella."
  elif jq -en --argjson value "$temp_drop" --argjson limit "$TEMP_DROP_THRESHOLD" '$value >= $limit' >/dev/null; then
    notify_weather normal "The forecast for later today is cooler by up to ${temp_drop}°F.<br/>Consider bringing an extra layer."
  fi
  save_state "$state" "$current" || return 1
  find "$state_dir" -maxdepth 1 -type f -name 'today-*.json' -mtime +2 -delete 2>/dev/null || true
}

check_tomorrow() {
  local tomorrow data max_prob rain_total max_temp min_temp swing alert_state
  fetch_weather || {
    echo 'Could not fetch location and weather data.' >&2
    return 1
  }
  tomorrow=$(TZ="$FORECAST_TIMEZONE" date -d tomorrow +%F)
  alert_state="$state_dir/tomorrow-alerted"
  if [[ -f "$alert_state" ]] && [[ "$(cat "$alert_state")" == "$tomorrow" ]]; then
    return 0
  fi
  data=$(jq -c --arg day "$tomorrow" '
    [.hourly as $h | range(0; $h.time | length) as $i
      | select($h.time[$i][0:10] == $day)
      | {temp: $h.temperature_2m[$i], rain_prob: $h.precipitation_probability[$i],
         rain: $h.precipitation[$i]}
      | select(.temp != null and .rain_prob != null and .rain != null)]' \
    <<<"$WEATHER_JSON") || return 1
  [[ "$(jq 'length' <<<"$data")" -gt 0 ]] || return 0
  max_prob=$(jq '[.[].rain_prob] | max' <<<"$data")
  rain_total=$(jq '[.[].rain] | add' <<<"$data")
  max_temp=$(jq '[.[].temp] | max' <<<"$data")
  min_temp=$(jq '[.[].temp] | min' <<<"$data")
  swing=$(jq -n --argjson high "$max_temp" --argjson low "$min_temp" '($high - $low) | round')

  if jq -en --argjson value "$max_prob" --argjson limit "$TOMORROW_RAIN_PROB" '$value >= $limit' >/dev/null; then
    notify_weather normal "Rain is likely tomorrow: ${max_prob}%, ${rain_total}mm.<br/>Consider taking an umbrella." || return 1
  elif jq -en --argjson value "$rain_total" --argjson limit "$TOMORROW_RAIN_AMOUNT" '$value >= $limit' >/dev/null; then
    notify_weather normal "Substantial rain tomorrow: ${max_prob}%, ${rain_total}mm." || return 1
  elif jq -en --argjson value "$swing" --argjson limit "$TOMORROW_TEMP_SWING" '$value >= $limit' >/dev/null; then
    notify_weather normal "Large temperature swing tomorrow.<br/>Low: ${min_temp}°F. High: ${max_temp}°F. Difference: ${swing}°F." || return 1
  else
    return 0
  fi
  save_state "$alert_state" "$tomorrow"
}

# Golden hour alert. Meant to run every ~10 min in the afternoon; it stays
# silent until sunset is within GOLDEN_LEAD_MIN minutes, then alerts once per day.
# Set GOLDEN_FORCE=1 to skip the time window and once-per-day check (for testing).
check_golden() {
  local force="${GOLDEN_FORCE:-0}" today alert_state sunset sunset_epoch mins_left
  local hr slot cloud prob mood sunset_label
  fetch_weather "$GOLDEN_CACHE_MIN" || {
    echo 'Could not fetch location and weather data.' >&2
    return 1
  }
  today=$(TZ="$FORECAST_TIMEZONE" date +%F)
  alert_state="$state_dir/golden-alerted"
  if [[ "$force" != 1 && -f "$alert_state" && "$(cat "$alert_state")" == "$today" ]]; then
    return 0
  fi

  sunset=$(jq -r --arg day "$today" '
    .daily as $d | [range(0; $d.time | length) as $i
      | select($d.time[$i] == $day) | $d.sunset[$i]] | first // empty' \
    <<<"$WEATHER_JSON") || return 1
  [[ -n "$sunset" ]] || return 0
  sunset_epoch=$(TZ="$FORECAST_TIMEZONE" date -d "${sunset/T/ }" +%s) || return 1
  mins_left=$(((sunset_epoch - $(date +%s)) / 60))
  if [[ "$force" != 1 ]] && ((mins_left > GOLDEN_LEAD_MIN || mins_left < GOLDEN_MIN_LEFT)); then
    return 0
  fi

  # Sky conditions in the hour containing sunset
  hr="${sunset:0:13}"
  slot=$(jq -c --arg hr "$hr" '
    [.hourly as $h | range(0; $h.time | length) as $i
      | select($h.time[$i][0:13] == $hr)
      | {cloud: $h.cloud_cover[$i], prob: $h.precipitation_probability[$i]}]
    | first // empty' <<<"$WEATHER_JSON") || return 1
  [[ -n "$slot" ]] || return 0
  cloud=$(jq -r '.cloud // empty' <<<"$slot")
  prob=$(jq -r '.prob // empty' <<<"$slot")
  [[ -n "$cloud" && -n "$prob" ]] || return 0
  cloud=${cloud%.*}
  prob=${prob%.*}

  if [[ "$force" != 1 ]] && ((prob >= GOLDEN_MAX_RAIN_PROB || cloud > GOLDEN_MAX_CLOUD)); then
    return 0
  fi

  if ((cloud <= 15)); then
    mood="Clear sky, clean golden light"
  elif ((cloud <= 45)); then
    mood="Scattered clouds, could be a colorful one"
  else
    mood="Fairly cloudy, but you might still catch some color"
  fi
  sunset_label=$(TZ="$FORECAST_TIMEZONE" date -d "@$sunset_epoch" '+%-I:%M %p')

  notify_weather normal "Golden hour: sunset at ${sunset_label} (${mins_left} min away).<br/>${mood} (${cloud}% cloud). Worth a walk outside?" || return 1
  [[ "$force" == 1 ]] || save_state "$alert_state" "$today"
}

test_notification() {
  fetch_weather || {
    echo 'Could not fetch location and weather data.' >&2
    return 1
  }
  printf 'Detected city: %s\nCoordinates: %s, %s\nForecast timezone: %s\n' \
    "$CITY" "$LAT" "$LON" "$FORECAST_TIMEZONE"
  notify_weather normal 'Weather notification test. Location, weather retrieval, and desktop notifications are working.'
}

case "${1:-}" in
today) check_today ;;
tomorrow) check_tomorrow ;;
golden) check_golden ;;
test) test_notification ;;
*)
  printf 'Usage: %s {today|tomorrow|golden|test}\n' "$0" >&2
  exit 1
  ;;
esac
