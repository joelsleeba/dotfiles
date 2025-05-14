#!/bin/zsh

if [[ -e $HOME/.config/bluetuith ]]; then
	cp -ru $HOME/.config/bluetuith ./
fi

if [[ -e $HOME/.config/btop ]]; then
	cp -ru $HOME/.config/btop ./
fi

if [[ -e $HOME/.config/cava ]]; then
	cp -ru $HOME/.config/cava ./
fi

if [[ -e $HOME/.config/clight ]]; then
	cp -ru $HOME/.config/clight ./
fi

if [[ -e $HOME/.config/clight.conf ]]; then
	cp -ru $HOME/.config/clight.conf ./
fi

if [[ -e $HOME/.config/cmus ]]; then
	cp -ru $HOME/.config/cmus ./
fi

if [[ -e $HOME/.config/dconf ]]; then
	cp -ru $HOME/.config/dconf ./
fi

if [[ -e $HOME/.config/foot ]]; then
	cp -ru $HOME/.config/foot ./
fi

if [[ -e $HOME/.config/gammastep ]]; then
	cp -ru $HOME/.config/gammastep ./
fi

if [[ -e $HOME/.config/greenclip.toml ]]; then
	cp -ru $HOME/.config/greenclip.toml ./
fi

if [[ -e $HOME/.config/gtk-2.0 ]]; then
	cp -ru $HOME/.config/gtk-2.0 ./
fi

if [[ -e $HOME/.config/gtk-3.0 ]]; then
	cp -ru $HOME/.config/gtk-3.0 ./
fi

if [[ -e $HOME/.config/gtk-4.0 ]]; then
	cp -ru $HOME/.config/gtk-4.0 ./
fi

if [[ -e $HOME/.config/helix ]]; then
	cp -ru $HOME/.config/helix ./
fi

if [[ -e $HOME/.config/htop ]]; then
	cp -ru $HOME/.config/htop ./
fi

if [[ -e $HOME/.config/hypr ]]; then
	cp -ru $HOME/.config/hypr ./
fi

if [[ -e $HOME/.config/i3 ]]; then
	cp -ru $HOME/.config/i3 ./
fi

if [[ -e $HOME/.config/i3status ]]; then
	cp -ru $HOME/.config/i3status ./
fi

if [[ -e $HOME/.config/kitty ]]; then
	cp -ru $HOME/.config/kitty ./
fi

if [[ -e $HOME/.config/luakit ]]; then
	cp -ru $HOME/.config/luakit ./
fi

if [[ -e $HOME/.config/lvim ]]; then
	cp -ru $HOME/.config/lvim ./
fi

if [[ -e $HOME/.config/mpd ]]; then
	cp -ru $HOME/.config/mpd ./
fi

if [[ -e $HOME/.config/mpv ]]; then
	cp -ru $HOME/.config/mpv ./
fi

if [[ -e $HOME/.config/ncmpcpp/ ]]; then
	cp -ru $HOME/.config/ncmpcpp/ ./
fi

if [[ -e $HOME/.config/neofetch ]]; then
	cp -ru $HOME/.config/neofetch ./
fi

if [[ -e $HOME/.config/nvim ]]; then
	cp -ru $HOME/.config/nvim ./
fi

if [[ -e $HOME/.config/ranger ]]; then
	cp -ru $HOME/.config/ranger ./
fi

if [[ -e $HOME/.config/rofi ]]; then
	cp -ru $HOME/.config/rofi ./
fi

if [[ -e $HOME/.config/userscripts/ ]]; then
	cp -ru $HOME/.config/userscripts/ ./
fi

if [[ -e $HOME/.config/sioyek ]]; then
	cp -ru $HOME/.config/sioyek ./
fi

if [[ -e $HOME/.config/sway ]]; then
	cp -ru $HOME/.config/sway ./
fi

if [[ -e $HOME/.config/swaylock ]]; then
	cp -ru $HOME/.config/swaylock ./
fi

if [[ -e $HOME/.local/share/themes ]]; then
	cp -ru $HOME/.local/share/themes ./
fi

if [[ -e $HOME/.config/tridactyl ]]; then
	cp -ru $HOME/.config/tridactyl ./
fi

if [[ -e $HOME/.config/uncrustify ]]; then
	cp -ru $HOME/.config/uncrustify ./
fi

if [[ -e $HOME/.config/waybar ]]; then
	cp -ru $HOME/.config/waybar ./
fi

if [[ -e $HOME/.config/wireplumber ]]; then
	cp -ru $HOME/.config/wireplumber ./
fi

if [[ -e $HOME/.config/wofi ]]; then
	cp -ru $HOME/.config/wofi ./
fi

if [[ -e $HOME/.config/yay ]]; then
	cp -ru $HOME/.config/yay ./
fi

if [[ -e $HOME/.bashrc ]]; then
	cp $HOME/.bashrc ./
fi

if [[ -e $HOME/.p10k.zsh ]]; then
	cp $HOME/.p10k.zsh ./
fi

cp -u $HOME/.waterfox/*default-release*/chrome/userChrome.css ./

if [[ -e $HOME/.vimrc ]]; then
	cp -u $HOME/.vimrc ./
fi

if [[ -e $HOME/.zshrc ]]; then
	cp -u $HOME/.zshrc ./
fi

