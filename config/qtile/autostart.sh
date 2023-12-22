#!/usr/bin/env bash 

### CHECKS IF VIRTUAL MACHINE ###
# If so, this sets an appropriate screen resolution.
# This is needed as part of DTOS.
if [[ $(systemd-detect-virt) = "none" ]]; then
    echo "Not running in a Virtual Machine";
elif xrandr | grep "1366x768"; then
    xrandr -s 1366x768 || echo "Cannot set 1366x768 resolution.";
elif xrandr | grep "1920x1080"; then
    xrandr -s 1920x1080 || echo "Cannot set 1920x1080 resolution.";
else echo "Could not set a resolution."
fi


# Monitors resolution
for monitor in $(xrandr -q | grep -w 'connected' | cut -d' ' -f1); do
    if [ "$monitor" = "DP-1" ]; then  
        xrandr --output "$monitor" --mode 1920x1080 --rate 60 --rotate normal --left-of eDP-1 --primary
    fi
    if [ "$monitor" = "eDP-1" ] ; then
        xrandr --output eDP-1 --mode 1920x1080 --rate 60 --rotate normal --primary
    fi
    #bspc monitor "$monitor" -d '' '' '' '' '' ''
done


### AUTOSTART PROGRAMS ###
picom --config "$HOME"/.config/picom/picom.conf &
copyq &
dunst &
# Wallpapers
feh -z --no-fehbg --bg-fill /usr/share/backgrounds
# Launch polkit
pidof -q polkit-gnome-authentication-agent-1 || { /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & }
