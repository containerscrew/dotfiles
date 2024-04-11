#!/bin/bash

killall eww
eww -c "$HOME"/.config/eww daemon &

# Launch bar
#echo "---" | tee -a /tmp/eww.log
#eww open --toggle bar 2>&1 | tee -a /tmp/eww.log & disown
#echo "Bar launched..."