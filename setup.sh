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


## DNS settings
#sudo ln -sf ../run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
#sudo systemctl restart systemd-resolved
#
## To be added
##mpd mpc
#
## Enable mpd service
##sudo systemctl enable --now mpd.service
#
## Cockpit
#sudo systemctl enable libvirtd.socket --now
#sudo usermod -aG libvirt "$USERNAME"
#sudo virsh net-autostart default
#sudo systemctl restart libvirtd
#
## Enable systemd-resolved.service service necessary for wireguard (wg-quick)
#sudo systemctl enable systemd-resolved.service --now
#
#
## Installing DevOps tooling
#log_message "info" "Installing DevOps tooling..."
#./scripts/devops_tooling_installer.sh
#
## Enable TOR
#sudo systemctl enable tor.service --now
#

## Necessary groups for my user
#sudo usermod -aG video,input,audio,storage,optical,lp,scanner,users "$USERNAME"
#
## Hibernation and sleep for autolock
## /etc/systemd/logind.conf
## change --> IdleAction
#
## Fc cache
#fc-cache -fv

#
## GTK theme
##https://www.gnome-look.org/p/1267246
## cp -R misc/Nordic-darker misc/Nordic-darker-v40 misc/Nordic-Folders "$HOME/.themes"
## gsettings set org.gnome.desktop.interface gtk-theme Nordic-darker
## gsettings set org.gnome.desktop.wm.preferences theme Nordic-darker
## gsettings set org.gnome.shell.extensions.user-theme name "Nordic-darker"
#
## VSCODE extensions
##log_message "info" "Installing vscode extensions..."
##./scripts/vscode-extensions.sh


## SSH agent
##systemctl --user enable ssh-agent.service --now
#
## Podman
#sudo cp ./misc/podman-config.conf /etc/containers/registries.conf.d/podman-config.conf
#
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
