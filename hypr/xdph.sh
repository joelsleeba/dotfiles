#!/bin/bash
sleep 1
killall -e xdg-desktop-portal-hyprland
killall -e xdg-desktop-portal-wlr
killall xdg-desktop-portal
exec /home/joel/workspace/xdg-desktop-portal-hyprland/build/xdg-desktop-portal-hyprland -v >/tmp/xdphlog &
sleep 2
/usr/lib/xdg-desktop-portal &
