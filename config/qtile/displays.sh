#! /bin/bash

# My logic is: at home I always close laptop screen. I only use 2 monitors, one horizontal and the other vertical (right position)
# At work, I use 3 monitors, laptop screen, and 2 more. Both in horizontal mode.

# Check if laptop screen is closed
lid_state=$(cat /proc/acpi/button/lid/LID0/state | awk '{print $2}')

echo "Laptop screen is $lid_state"

case $lid_state in
  closed)
    xrandr --output eDP-1 --off --output DP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-2 --mode 1920x1080 --pos 1920x0 --rotate right
    ;;

  open)
    xrandr --output eDP-1 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1 --primary --mode 1920x1080 --pos 1920x0 --rotate normal --output DP-2 --mode 1920x1080 --pos 3840x0 --rotate normal --output DP-3 --off
    ;;
  *)
    xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1 --off --output DP-2 --off --output DP-3 --off
    ;;
esac

# I need to add more logic. For example, if screen is opened, check also if other displays are conencted.


# Monitors resolution
#for monitor in $(xrandr -q | grep -w 'connected' | cut -d' ' -f1); do
#  echo "test"
#done
