#!/usr/bin/zsh

# GTK
export GTK_THEME='Gruvbox-Dark'
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
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# Qt with Kvantum
kvantummanager --set Gruvbox-Dark-Brown

echo "night" >/tmp/color_scheme

# Terminal and Shell
# theme.sh tokyo-night
ln -f -s /usr/share/foot/themes/gruvbox-dark ~/.config/foot/color
pkill -USR1 zsh

# Wallpaper
# hyprctl hyprpaper wallpaper ",$HOME/.config/userscripts/walls/kurzgesagt/day.jpg"

# Mako
ln -f -s $HOME/.config/mako/tokyo-night.conf $HOME/.config/mako/config
makoctl reload

# Rofi
ln -f -s $HOME/.config/rofi/themes/gruvbox-dark-hard.rasi $HOME/.config/rofi/colorscheme.rasi

# zathura and sioyek
ln -f -s $HOME/.config/zathura/zathurarc-dark $HOME/.config/zathura/zathurarc
ln -f -s $HOME/.config/sioyek/prefs_user-dark.config $HOME/.config/sioyek/prefs_user.config

# hyprlock
ln -f -s $HOME/.config/hypr/hypr.d/hyprlock-dark.conf $HOME/.config/hypr/hyprlock.conf

# set wallpaper at last since it doesn't daemonize
ln -f -s $HOME/.config/userscripts/walls/gruvbox/dark-samurai.png $HOME/.config/userscripts/walls/wallpaper.png
killall swaybg
swaybg -m fill -i $HOME/.config/userscripts/walls/wallpaper.png
