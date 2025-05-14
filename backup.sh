#!/bin/zsh

for conf in "$@"
do
	cp -ru $conf ~/.config/"$conf"
done

