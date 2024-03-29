#! /bin/bash

# Don't run this script as root
if [ "$(id -u)" = 0 ]; then
    echo "This script MUST NOT be run as root user."
    exit 1
fi

# Stop script if errors
set -euo pipefail #x

############### SOURCE FILES ###############
source installers/banner.sh
source installers/logger.sh
############### SOURCE FILES ###############

############### BANNER ###############
print_ascii_banner
############### BANNER ###############

############### SYSTEM PACKAGES ###############
log_message "info" "Installing packages"
./installers/packages.sh
############### SYSTEM PACKAGES ###############

############### CORE CONFIG ###############
log_message "info" "Installing packages"
./installers/core_config.sh
############### CORE CONFIG ###############

############### USER CONFIG ###############
log_message "info" "User configurations"
./installers/user_config.sh
############### USER CONFIG ###############

############### POWER CONFIG ###############
./installers/power_config.sh
############### POWER CONFIG ###############

############### NETWORKING, DNS, FIREWALL ###############
log_message "info" "Setup networking, dns, firewall"
./installers/networking.sh
############### NETWORKING, DNS, FIREWALL ###############

############### DISPLAY MANAGER ###############
log_message "info" "Setup display manager"
./installers/display-manager.sh
############### DISPLAY MANAGER ###############

## Enable mpd service
##sudo systemctl enable --now mpd.service
#
## Cockpit
#sudo systemctl enable libvirtd.socket --now
#sudo usermod -aG libvirt "$USERNAME"
#sudo virsh net-autostart default
#sudo systemctl restart libvirtd
#

## Installing DevOps tooling
#log_message "info" "Installing DevOps tooling..."
#./scripts/devops_tooling_installer.sh
#
## Enable TOR
#sudo systemctl enable tor.service --now
#

## Hibernation and sleep for autolock
## /etc/systemd/logind.conf
## change --> IdleAction


## SSH agent
##systemctl --user enable ssh-agent.service --now

## Some npm packages
#if ! command -v "doctoc" &> /dev/null ; then
#  sudo npm install -g doctoc
#fi
#
## Fish ssh-agent
#if [ ! -f "$HOME/.config/fish/functions/fish_ssh_agent.fish" ]; then wget https://gitlab.com/kyb/fish_ssh_agent/raw/master/functions/fish_ssh_agent.fish -P ~/.config/fish/functions/; fi
#
## Install oh my tmux
#if [ ! -d "$HOME/.tmux" ]; then
#  cd "$HOME"
#  git clone https://github.com/gpakosz/.tmux.git
#  ln -s "$HOME/.tmux/.tmux.conf" "$HOME/.config/tmux/tmux.conf"
#  cp config/tmux/tmux.conf.local "$HOME/.config/tmux/tmux.conf.local"
#else
#  cp config/tmux/tmux.conf.local "$HOME/.config/tmux/tmux.conf.local"
#fi
##cp "$HOME/.tmux/.tmux.conf.local" "$HOME/.config/tmux/tmux.conf.local"
#
#
## Setup
## For the end of the script
##sudo systemctl enable lightdm.service --now
## https://wiki.archlinux.org/title/SDDM
#mkdir -p /etc/sddm.conf.d/
#cp /usr/lib/sddm/sddm.conf.d/default.conf /etc/sddm.conf.d/
