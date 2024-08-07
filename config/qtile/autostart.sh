#!/usr/bin/env bash

### AUTOSTART PROGRAMS ###
picom --config "$HOME"/.config/picom/picom.conf &

# Clipboard manager
copyq &

# Notifications
dunst &

# Set custom wallpaper, change the wallpaper to random wallpaper using SUPR(WIN)+ALT+P
feh --bg-scale /usr/share/backgrounds/15.webp

# EWW widgets
"$HOME/.config/eww/launch.sh"

# Light locker
light-locker --no-lock-on-lid &

# Launch polkit
#pidof -q polkitd || /usr/bin/lxqt-policykit-agent &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Script for autoarrange
~/.local/bin/autoarrange

# Debian 12
#lxpolkit &

# Other apps for systray
#udiskie -t &
#nm-applet &
#volumeicon &
#cbatticon &

# Conky
#killall conky
#sleep 2s
#conky -c "$HOME"/.config/conky/Antares/Antares.conf &> /tmp/conky.log &
