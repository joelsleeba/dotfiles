#!/usr/bin/env bash
# A `rofi` wrapper, with image previews.
# Usage: /path/to/clipvault_rofi.sh

list=$(clipvault list)
thumbnails_dir="${XDG_CACHE_HOME:-$HOME/.cache}/clipvault/thumbs"

# Ensure thumbnail directory exists
[ -d "$thumbnails_dir" ] || mkdir -p "$thumbnails_dir"

# Delete thumbnails that are no longer in the DB
find "$thumbnails_dir" -type f | while IFS= read -r thumbnail; do
  item_id=$(basename "${thumbnail%.*}")
  if ! grep -q "^${item_id}\s\[\[ binary data" <<<"$list"; then
    rm "$thumbnail"
  fi
done

# Generates thumbnails (for matched image formats) for entries which don't already have one in the
# thumbnails directory, and returns entries ready to be displayed by `wofi`.
read -r -d '' prog <<EOF
/^[0-9]+\s<meta http-equiv=/ { next }
match(\$0, /^([0-9]+)\s\[\[\sbinary.*(jpg|jpeg|png|bmp|webp|tif|gif)/, grp) {
    image = grp[1]"."grp[2]
    system("[[ -f ${thumbnails_dir}/"image" ]] || echo " grp[1] " | clipvault get >${thumbnails_dir}/"image)
    print "text:"grp[1]"\\t:img:$thumbnails_dir/"image
    next
}
1
EOF

#Get the choice returned by `wofi`, exiting early if nothing was chosen
choice=$(gawk <<<"$list" "$prog" | wofi -I --dmenu --prompt "Clipboard" -Dimage_size=100 -Dynamic_lines=true -d -k /dev/null)
if [ "$choice" = "" ]; then
  exit 1
fi

############### ROFI Config #######################

# Generates thumbnails (for matched image formats) for entries which don't already have one in the
# thumbnails directory, and returns entries ready to be displayed by `rofi`.
# Each row below is either the raw `clipvault list` line (so it can be fed straight back to
# `clipvault get`), or the same line with rofi's icon metadata appended to it:
#   <row>\0icon\x1f<thumbnail path>
# rofi's dmenu mode renders that image as the row's icon when launched with `-show-icons`,
# and strips the metadata from the selected entry.
read -r -d '' prog <<EOF
/^[0-9]+\s<meta http-equiv=/ { next }
match(\$0, /^([0-9]+)\s\[\[\sbinary.*(jpg|jpeg|png|bmp|webp|tif|gif)/, grp) {
    image = grp[1] "." grp[2]
    system("[[ -f ${thumbnails_dir}/"image" ]] || echo " grp[1] " | clipvault get > ${thumbnails_dir}/"image)
    printf "%s\0icon\037${thumbnails_dir}/%s\n", \$0, image
    next
}
1
EOF

# Get the choice returned by `rofi`, exiting early if nothing was chosen
# (-show-icons draws the thumbnail icons; element-icon sizes the previews)
# NOTE: don't use `-only-match` here -- it makes rofi IGNORE Escape (it restarts
# the selection to guarantee an entry) instead of exiting like wofi did.
choice=$(gawk <<<"$list" "$prog" | rofi -dmenu -show-icons \
  -p 'Clipboard' -l 15 -i \
  -theme-str 'element-icon { size: 25 px; }')
if [ "$choice" = "" ]; then
  exit 1
fi

#######################################

# Trim `text:` from the beginning of the chosen entry (if present)
if [ "${choice::5}" = "text:" ]; then
  choice="${choice:5}"
fi

echo "$choice" | clipvault get | wl-copy
