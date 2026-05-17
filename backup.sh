#!/bin/bash

for conf in $@; do
  cp -r ~/.config/$conf ~/workspace/dotfiles/$conf
done
