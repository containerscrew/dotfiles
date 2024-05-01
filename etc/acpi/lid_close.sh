#!/bin/bash

#sudo -u dcr autoarrange
sudo -u dcr xrandr -display :0.0 --output eDP-1 --off --output DP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-2 --off --output DP-3 --off | sudo -u dcr tee -a /tmp/xrandr.log 2>&1