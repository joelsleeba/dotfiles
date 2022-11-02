#!/bin/bash

if [[ -e $HOME/.config/i3 ]];
then
	cp -r $HOME/.config/i3 ./
fi

if [[ -e $HOME/.config/i3status ]];
then
	cp -r $HOME/.config/i3status ./
fi

if [[ -e $HOME/.config/kitty ]];
then
	cp -r $HOME/.config/kitty ./
fi

if [[ -e $HOME/.config/rofi ]];
then
	cp -r $HOME/.config/rofi ./
fi

if [[ -e $HOME/.config/nvim ]];
then
	cp -r $HOME/.config/nvim ./
fi

if [[ -e $HOME/.config/cmus ]];
then
	cp -r $HOME/.config/cmus ./
fi

if [[ -e $HOME/.config/ranger ]];
then
	cp -r $HOME/.config/ranger ./
fi

if [[ -e $HOME/.p10k.zsh ]];
then
	cp $HOME/.p10k.zsh ./
fi

if [[ -e $HOME/.bashrc ]];
then
	cp $HOME/.bashrc ./
fi

if [[ -e $HOME/.zshrc ]];
then
	cp $HOME/.zshrc ./
fi





