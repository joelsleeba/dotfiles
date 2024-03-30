#!/usr/bin/zsh

# GTK
export GTK_THEME="Tokyonight-Light"
THEME_DIR="$HOME/.local/share/themes/"

# GTK2
export GTK2_RC_FILES="${THEME_DIR}/${GTK_THEME}/gtk-2.0/gtkrc"

# GTK3
gsettings set org.gnome.desktop.interface gtk-theme $GTK_THEME

# GTK4
if [[ -e $HOME/.config/gtk-4.0 ]] || $(mkdir -p $HOME/.config/gtk-4.0/); then
	ln -sf "${THEME_DIR}/${GTK_THEME}/gtk-4.0/assets" "${HOME}/.config/gtk-4.0/assets"
	ln -sf "${THEME_DIR}/${GTK_THEME}/gtk-4.0/gtk.css" "${HOME}/.config/gtk-4.0/gtk.css"
	ln -sf "${THEME_DIR}/${GTK_THEME}/gtk-4.0/gtk-dark.css" "${HOME}/.config/gtk-4.0/gtk-dark.css"
fi
gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'

echo "day" >/tmp/color_scheme

# Terminal and Shell
# theme.sh tokyo-day
ln -f -s /usr/share/foot/themes/tokyonight-day ~/.config/foot/color
pkill -USR1 zsh

# Wallpaper
# hyprctl hyprpaper wallpaper ",$HOME/.config/userscripts/walls/kurzgesagt/day.jpg"

# Mako
ln -f -s $HOME/.config/mako/tokyo-day.conf $HOME/.config/mako/config
makoctl reload

# set wallpaper at last. It doesn't daemonize
killall swaybg
swaybg -m fill -i $HOME/.config/userscripts/walls/kurzgesagt/day.jpg
