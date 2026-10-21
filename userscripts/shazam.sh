#!/bin/bash
# Author: Joel

usage() { echo "Usage: $0 [-notify]"; }

case "$1" in
-h | --help)
  usage
  exit 0
  ;;
-notify | "") ;;
*)
  echo "Unknown option: $1" >&2
  usage >&2
  exit 1
  ;;
esac

mkdir -p /tmp/shazam

yt_song_link() {
  local q
  q=${1#*q=}
  q=${q%%&*}
  q=${q//+/ }
  q=$(printf '%b' "${q//%/\\x}")
  python -c 'import sys; from ytmusicapi import YTMusic
r = YTMusic().search(sys.argv[1], filter="songs", limit=1)
print("https://music.youtube.com/watch?v=" + r[0]["videoId"])' "$q" 2>/dev/null
}

# --- Limusic hook -----------------------------------------------------------
# Adjust this to however Limusic accepts a track/URL (see note below).
open_in_limusic() {
  # setsid -f limusic "$1" >/dev/null 2>&1
  limusic-app "$1"
}
# ----------------------------------------------------------------------------

sox -d -t raw -b 24 -e signed-integer -r 44100 -c 1 - gain 3 2>/dev/null |
  vibra --recognize --seconds 5 --rate 44100 --channels 1 --bits 24 >/tmp/shazam/result.json

song=$(jq -r '.track.title // empty' /tmp/shazam/result.json)
artist=$(jq -r '.track.subtitle // empty' /tmp/shazam/result.json)
[[ -z "$song" || -z "$artist" ]] && exit 0

info="$song\t $artist"
lastinfo=$(tail -n 1 ~/.shazam 2>/dev/null)
if [[ "$lastinfo" != "$info"* ]]; then
  echo -e "$info\t $(date)" >>~/.shazam
fi

[[ "$1" == "-notify" ]] || exit 0

# YouTube Music entry from Shazam's provider list
yt=$(jq -r '.track.hub.providers[]? | select(.type=="YOUTUBEMUSIC") | .actions[0].uri // empty' /tmp/shazam/result.json)

# Fallback: build the same kind of search URL ourselves
if [[ -z "$yt" ]]; then
  q=$(jq -rn --arg q "$song $artist" '$q|@uri')
  yt="https://music.youtube.com/search?q=$q"
fi

yt=$(yt_song_link "$yt" || echo "$yt")

art=/tmp/shazam/album_art.jpg
albumarturl=$(jq -r '.track.images.coverart // empty' /tmp/shazam/result.json)
curl -fsSL "$albumarturl" -o "$art" || art=audio-x-generic

notify_song() {
  if [[ -n "$yt" ]]; then
    local choice
    choice=$(notify-send -c shazam -i "$art" --wait \
      --action="default=Open in YouTube Music" "$song" "$artist")
    [[ "$choice" == default ]] && open_in_limusic "$yt"
  else
    notify-send -c shazam -i "$art" "$song" "$artist"
  fi
}

# --wait blocks until the notification closes, so don't hold up the timer
notify_song &
disown
