#!/usr/bin/env bash

# Check if laptop screen is closed
lid_state=$(cat /proc/acpi/button/lid/LID0/state | awk '{print $2}')

# My logic is: at home I always close laptop screen. I only use 2 monitors, one horizontal and the other vertical (right position)
# At work, I use 3 monitors, laptop screen, and 2 more. Both in horizontal mode.

# So, if laptop screen is closed, apply home config, if not, apply work config :)
# For temporal configurations (you are sharing your laptop in a talk or something like that, use arandr (xrandr GUI))
if [ "$lid_state" == "closed" ]; then
    xrandr --output eDP-1 --off --output DP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-2 --mode 1920x1080 --pos 1920x0 --rotate right
else
    echo "Pending to add"
    #xrandr --output eDP-1 --off --output DP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-2 --mode 1920x1080 --pos 1920x0 --rotate right --output DP-3 --off
fi

# Monitors resolution
#for monitor in $(xrandr -q | grep -w 'connected' | cut -d' ' -f1); do
#  echo "test"
#done


### AUTOSTART PROGRAMS ###
picom --config "$HOME"/.config/picom/picom.conf &

# Clipboard manager
copyq &

# Notifications
dunst &

# Wallpapers
feh -z --no-fehbg --bg-fill /usr/share/backgrounds

# Launch polkit
pidof -q polkit-gnome-authentication-agent-1 || { /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & }

# EWW widgets
"$HOME/.config/eww/launch.sh"

# Other apps for systray
#udiskie -t &
#nm-applet &
#volumeicon &
#cbatticon &
