#!/bin/bash

if [[ -e ./i3 ]]; then
	cp -r ./i3 $HOME/.config/
fi

if [[ -e ./i3status ]]; then
	cp -r ./i3status $HOME/.config/
fi

if [[ -e ./kitty ]]; then
	cp -r ./kitty $HOME/.config/
fi

if [[ -e ./rofi ]]; then
	cp -r ./rofi $HOME/.config/
fi

if [[ -e ./nvim ]]; then
	cp -r ./nvim $HOME/.config/
fi

if [[ -e ./lvim ]]; then
	cp -r ./lvim $HOME/.config/
fi

if [[ -e ./cmus ]]; then
	cp -r ./cmus $HOME/.config/
fi

if [[ -e ./ranger ]]; then
	cp -r ./ranger $HOME/.config/
fi

if [[ -e ./rofi ]]; then
	cp -r ./rofi $HOME/.config/
fi

if [[ -e ./sway ]]; then
	cp -r ./sway $HOME/.config/
fi

if [[ -e ./waybar ]]; then
	cp -r ./waybar $HOME/.config/
fi

if [[ -e ./foot ]]; then
	cp -r ./foot $HOME/.config/
fi

if [[ -e ./uncrustify ]]; then
	cp -r ./uncrustify $HOME/.config/
fi

if [[ -e ./greenclip.toml ]]; then
	cp -r ./greenclip.toml $HOME/.config/
fi

if [[ -e ./sioyek ]]; then
	cp -r ./sioyek $HOME/.config/
fi

if [[ -e ./.p10k.zsh ]]; then
	cp ./.p10k.zsh $HOME/.p10k.zsh
fi

if [[ -e ./.bashrc ]]; then
	cp ./.bashrc $HOME/.bashrc
fi

if [[ -e ./.vimrc ]]; then
	cp ./.vimrc $HOME/.vimrc
fi

if [[ -e ./.zshrc ]]; then
	cp ./.zshrc $HOME/.zshrc
fi
