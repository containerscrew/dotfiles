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

# Test
echo "test" >> /tmp/test.txt

# Other apps for systray
#udiskie -t &
#nm-applet &
#volumeicon &
#cbatticon &
