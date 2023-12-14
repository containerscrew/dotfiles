#! /usr/bin/env bash

# Stop script if errors
set -euo pipefail #x

# Define ANSI colors
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' 

# Logger
log_message() {
    local color=""
    local message_type="$1"
    local message="$2"

    case "$message_type" in
        "error")
            color="$RED"
            ;;
        "warning")
            color="$YELLOW"
            ;;
        "info")
            color="$GREEN"
            ;;
        *)
            echo "Unknown message type: $message_type"
            return 1
            ;;
    esac

    echo -e "[${color}${message_type}]${NC} $message"
}


# Banner
print_ascii_banner() {
    echo -e "${BLUE}
                    /-
                   ooo: 
                  yoooo/
                 yooooooo
                yooooooooo
               yooooooooooo
             .yooooooooooooo 
            .oooooooooooooooo          Welcome to ohmyarch!
           .oooooooarcoooooooo         author: github.com/containerscrew
          .ooooooooo-oooooooooo 
         .ooooooooo-  oooooooooo
        :ooooooooo.    :ooooooooo
       :ooooooooo.      :ooooooooo
      :oooarcooo         .oooarcooo
     :ooooooooy           .ooooooooo
    :ooooooooo   /ooooooooooooooooooo
   :ooooooooo      .-ooooooooooooooooo.
  ooooooooo-             -ooooooooooooo.
 ooooooooo-                 .-oooooooooo.
ooooooooo.                     -ooooooooo
${NC}"
}

# Don't run this script as root
if [ "$(id -u)" = 0 ]; then
    echo "This script MUST NOT be run as root user."
    exit 1
fi

# Sudo is needed
if ! command -v "sudo" &> /dev/null ; then 
    log_message "error" "Sudo is needed! Install it: pacman -S sudo and add the corresponding user to the sudo group. $ usermod -aG sudo USERNAME"
    exit 1
fi

print_ascii_banner

# Install base de pendencies
log_message "info" "Installing system dependencies..."

# For BSPWM 
# sudo pacman -Sy --noconfirm --needed base-devel rustup bspwm sxhkd polybar picom \
#             dmenu dunst feh alacritty jq git papirus-icon-theme rofi \
#             xorg-xprop xorg-xkill xorg-xsetroot xorg-xwininfo xorg-xrandr \
#             xdg-user-dirs plymouth flameshot neovim vscode mlocate \
#             bluez bluez-utils fish arandr xorg-server xorg-xinit \
#             curl wget neofetch lightdm lightdm-gtk-greeter lightdm-webkit2-greeter \
#             blueman firefox conky

# For Gnome
sudo pacman -Syu --noconfirm --needed base-devel rustup alacritty jq git papirus-icon-theme rofi \
            flameshot neovim vscode mlocate \
            fish curl wget neofetch conky gnome-extra gnome gnome-tweaks


# Install gdm 
sudo systemctl enable gdm --now


# Start bluetooth service
sudo systemctl enable bluetooth --now

# # Copy wallpapers 
# log_message "info" "Copying wallpapers to /usr/share/backgrounds..."
# sudo mkdir -p /usr/share/backgrounds
# sudo cp -aR wallpapers/* /usr/share/backgrounds/

# # Copy config folders
# # NEED TO IMPLEMENT SOME BACKUP BEFORE INSTALL THAT CUSTOMS FILES
# cp -R config/* $HOME/.config/

# # Create default user home directories
# log_message "info" "Creating default user home directories..."
# if ! test -f  "$HOME/.config/user-dirs.dirs" ; then
#     xdg-user-dirs-update
# else 
#     log_message "info" "User home directories exists. Skipping creation..."
# fi
# sleep 2

# # # Function to clean tmp directories
# clean(){
#   log_message "warning" "Cleaning $1"
#   sudo rm -rf "$1"
# }

# # Install paru for AUR packages
# log_message "info" "Installing paru AUR package manaer..."

# if ! command -v "paru" &> /dev/null ; then 
#     tmpdir=$(mktemp -d)
#     cd "$tmpdir"
#     git clone https://aur.archlinux.org/paru-bin.git
#     cd paru-bin || exit
#     makepkg -si --noconfirm
#     clean "$tmpdir"
# else
#     log_message "info" "Command exists. Skipping installation..."
# fi

# # Install other packages with paru
# log_message "info" "Installing some packages from AUR..."
# paru -S web-greeter-theme-shikai --skipreview --noconfirm --needed

# # Setup fish shell
# log_message "info" "Setup fish shell..."
# chsh -s "$(which fish)"
# [ -f "$HOME"/.config/fish/config.fish ] && cp "$HOME"/.config/fish/config.fish "$HOME"/.config/fish/config.fish.bak
# #cp misc/config.fish "$HOME"/.config/fish/config.fish
# # Setup oh my fish and plugins
# ./scripts/fish.sh


# log_message "info" "Installing blackarch repository..."
# if pacman -Slq | grep -q blackarch; then
#     log_message "info" "Blackarch repository already installed. Skipping installation..."
# else
#     tmpdir=$(mktemp -d)
#     cd "$tmpdir"
#     curl -O https://blackarch.org/strap.sh
#     chmod +x strap.sh
#     sudo ./strap.sh
#     clean "$tmpdir"
# fi

# # Install eww
# if ! command -v "eww" &> /dev/null ; then 
#     tmpdir=$(mktemp -d)
#     cd "$tmpdir"
#     git clone https://github.com/elkowar/eww
#     cd eww
#     cargo build --release --no-default-features --features x11
#     sudo install -m 755 "target/release/eww" -t /usr/bin/
#     clean "$tmpdir"
# else
#     log_message "info" "Command eww exists. Skipping installation..."
# fi

# # Setup shikai theme
# log_message "info" "Setting up shikai lightdm theme..."
# # Backup existing config
# sudo cp /etc/lightdm/lightdm.conf /etc/lightdm/lightdm.conf.bak
# sudo cp /etc/lightdm/web-greeter.yml /etc/lightdm/web-greeter.yml.bak
# sudo sed -i 's/theme: .*/theme: shikai/' /etc/lightdm/web-greeter.yml
# sudo sed -i 's/.*greeter-session=.*/greeter-session=web-greeter/g' /etc/lightdm/lightdm.conf
# sudo sed -i 's/background_images_dir: .*/background_images_dir: \/usr\/share\/web-greeter\/themes\/shikai\/assets\/media\/wallpapers/' /etc/lightdm/web-greeter.yml
# sudo sed -i 's/logo_image: .*/logo_image: \/usr\/share\/web-greeter\/themes\/shikai\/assets\/media\/logos/' /etc/lightdm/web-greeter.yml


# # For the end of the script
# sudo systemctl enable lightdm.service --now