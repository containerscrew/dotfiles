#! /bin/bash

# Don't run this script as root
if [ "$(id -u)" = 0 ]; then
    echo "This script MUST NOT be run as root user."
    exit 1
fi

# Stop script if errors
set -euo pipefail #x

############### SOURCE FILES ###############
source installation/banner.sh
source installation/logger.sh
############### SOURCE FILES ###############

############### BANNER ###############
print_ascii_banner
############### BANNER ###############

############### SYSTEM PACKAGES ###############
log_message "info" "Installing packages..."
./installation/packages.sh
############### SYSTEM PACKAGES ###############

############### USER CONFIG ###############
log_message "info" "User configurations..."
./installation/user_config.sh
############### USER CONFIG ###############

############### POWER CONFIG ###############
./installation/power_config.sh
############### POWER CONFIG ###############

############### DISPLAY MANAGER ###############
log_message "info" "Setup display manager..."
sudo systemctl enable lightdm.service --now
############### DISPLAY MANAGER ###############

############### NETWORKING, DNS, FIREWALL ###############
log_message "info" "Setup networking, dns, firewall..."
./installation/networking.sh
############### NETWORKING, DNS, FIREWALL ###############



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
## Start bluetooth service
#log_message "info" "Starting bluetooh service..."
#sudo systemctl enable bluetooth --now
#
## Copy wallpapers
#log_message "info" "Copying wallpapers to /usr/share/backgrounds..."
#sudo mkdir -p /usr/share/backgrounds
#sudo cp -aR wallpapers/* /usr/share/backgrounds/
#
#
## Create default user home directories
#log_message "info" "Creating default user home directories..."
#if ! test -f  "$HOME/.config/user-dirs.dirs" ; then
#    xdg-user-dirs-update
#    mkdir -p $HOME/.ssh $HOME/.kube $HOME/.aws $HOME/.themes $HOME/.icons $HOME/.local/bin $HOME/Documents/Code \
#            $HOME/Documents/Code/Work $HOME/Documents/Code/Personal $HOME/Documents/Code/Work $HOME/Documents/Private \
#            $HOME/Documents/Code/Work $HOME/Documents/Books
#else
#    log_message "info" "User home directories exists. Skipping creation..."
#fi
#sleep 2
#
## Copy config folders
## NEED TO IMPLEMENT SOME BACKUP BEFORE INSTALL THAT CUSTOMS FILES
#
### IMPORTANTTTTT
### BEFORE EXECUTE CP, execute a diff
### You cant to continue? There are changes from your config in git and your local!!! :)
### DO you want to create a backup?
#cp -R config/* $HOME/.config/


#
## Install other packages with paru
#log_message "info" "Installing some packages from AUR..."
## paru -Sccd
#paru -Sccd jetbrains-toolbox coreimage qtile-extras python-pulsectl-asyncio mkdocs mkdocs-rss-plugin mkdocs-material \
#        ttf-font-awesome brave-bin insomnia archlinux-themes-sddm sddm-conf ttf-gentium-basic balena-etcher \
#        slack-desktop gitleaks procs gosec aws-session-manager-plugin --skipreview --noconfirm --needed
#
## web-greeter-theme-shikai
#
## Setup fish shell
## Ansible OK
#log_message "info" "Setup fish shell..."
#sudo chsh -s "$(which fish)" "${USERNAME}"
#mkdir -p "$HOME/.config/fish"
#mkdir -p "$HOME/.config/fish/functions"
#[ -f "$HOME"/.config/fish/config.fish ] && cp "$HOME"/.config/fish/config.fish "$HOME"/.config/fish/config.fish.bak
## Setup fish config
#cp misc/config.fish "$HOME"/.config/fish/config.fish
#cp misc/aws-profile.fish "$HOME/.config/fish/functions/"
#cp misc/tfsum.fish "$HOME/.config/fish/functions/"
#cp misc/fish_variables "$HOME/.config/fish/fish_variables"
#cp misc/batdiff.fish "$HOME/.config/fish/functions/"
#if [ ! -f "$HOME/.config/fish/functions/git-containerscrew.fish" ]; then cp misc/git-containerscrew.fish "$HOME/.config/fish/functions/git-containerscrew.fish"; fi
#if [ ! -f "$HOME/.config/fish/functions/git-work.fish" ]; then cp misc/git-work.fish "$HOME/.config/fish/functions/git-work.fish"; fi
#
#
## Install eww
#if ! command -v "eww" &> /dev/null ; then
#    tmpdir=$(mktemp -d)
#    cd "$tmpdir"
#    git clone https://github.com/elkowar/eww
#    cd eww
#    cargo build --release --no-default-features --features x11
#    sudo install -m 755 "target/release/eww" -t /usr/bin/
#    clean "$tmpdir"
#else
#    log_message "info" "Command eww exists. Skipping installation...":
#fi
#
## Setup shikai theme
##log_message "info" "Setting up shikai lightdm theme..."
## # Backup existing config
##sudo cp /etc/lightdm/lightdm.conf /etc/lightdm/lightdm.conf.bak
##sudo cp /etc/lightdm/web-greeter.yml /etc/lightdm/web-greeter.yml.bak
##sudo sed -i 's/theme: .*/theme: shikai/' /etc/lightdm/web-greeter.yml
##sudo sed -i 's/.*greeter-session=.*/greeter-session=web-greeter/g' /etc/lightdm/lightdm.conf
##sudo sed -i 's/background_images_dir: .*/background_images_dir: \/usr\/share\/backgrounds/' /etc/lightdm/web-greeter.yml
##sudo sed -i 's/logo_image: .*/logo_image: \/usr\/share\/web-greeter\/themes\/shikai\/assets\/media\/logos/' /etc/lightdm/web-greeter.yml
##cp assets/arch-logo.png "$HOME/.face"
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
#
## Security
## sudo cp /etc/pam.d/passwd /etc/pam.d/passwd."$(date +"%Y%m%d_%H%M")".backup
## sudo cp misc/passwd /etc/pam.d/passwd
#
## Etc hosts
## log_message "info" "Setup /etc/hosts file..."
## printf "127.0.0.1    localhost \n::1     localhost" | sudo tee -a /etc/hosts
#
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
