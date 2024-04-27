#!/usr/bin/env bash

### AUTOSTART PROGRAMS ###
picom --config "$HOME"/.config/picom/picom.conf &

# Clipboard manager
copyq &

# Notifications
dunst &

# Wallpapers
feh -z --no-fehbg --bg-fill /usr/share/backgrounds

# EWW widgets
"$HOME/.config/eww/launch.sh"

# Light locker
light-locker &

# Launch polkit
pidof -q polkitd || /usr/bin/lxqt-policykit-agent &

# Debian 12
#lxpolkit &

# Other apps for systray
#udiskie -t &
nm-applet &
#volumeicon &
#cbatticon &

# Conky
killall conky
sleep 2s
conky -c "$HOME"/.config/conky/Antares/Antares.conf &> /tmp/conky.log &