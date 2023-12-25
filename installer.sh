#! /usr/bin/env bash

# Username of your laptop
USERNAME="elliot"

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
            .oooooooooooooooo          Welcome to my dotfiles!
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

sudo pacman -Sy --noconfirm --needed base-devel rustup bspwm sxhkd polybar picom \
            dunst feh alacritty jq git papirus-icon-theme rofi \
            xorg-xprop xorg-xkill xorg-xsetroot xorg-xwininfo xorg-xrandr \
            xdg-user-dirs plymouth neovim vscode mlocate \
            bluez bluez-utils fish arandr xorg-server xorg-xinit \
            curl wget neofetch lightdm lightdm-gtk-greeter lightdm-webkit2-greeter \
            blueman firefox conky mlocate tor tor-browser ngrep lsd bat \
            ttf-jetbrains-mono ttf-jetbrains-mono-nerd ttf-terminus-nerd ttf-inconsolata ttf-joypixels \
            fzf brightnessctl man webp-pixbuf-loader light-locker \
            net-tools inetutils ttf-nerd-fonts-symbols htop thunar discord openvpn veracrypt \
            keepass pluma bitwarden pamixer python3 python-pip shutter signal-desktop qpwgraph \
            pipewire pipewire-pulse pavucontrol xbindkeys ttf-firacode-nerd wireguard-tools \
            systemd-resolvconf macchanger tcpdump imagemagick vpnc whois qemu-full virt-manager \
            dnsmasq qtile xorg-xwayland rsync copyq python-dbus-next python-iwlib \
            traceroute pre-commit goreleaser noto-fonts-emoji noto-fonts-extra \
            nyx udiskie ntfs-3g network-manager-applet volumeicon cbatticon

# Cockpit 
sudo systemctl enable libvirtd.socket --now
sudo usermod -aG libvirt "$USERNAME"
sudo virsh net-autostart default
sudo systemctl restart libvirtd

# Enable systemd-resolved.service service necessary for wireguard (wg-quick)
sudo systemctl enable systemd-resolved.service --now

# Security tools
log_message "info" "Installing security tools..."
sudo pacman -Sy --noconfirm --needed nmap ufw

# Enable firewall
sudo systemctl enable ufw --now
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable
sudo ufw logging on
sudo ufw reload
sudo ufw status verbose

# Installing DevOps tooling
log_message "info" "Installing DevOps tooling..."
./scripts/devops_tooling_installer.sh

# Enable TOR
sudo systemctl enable tor --now

# Start bluetooth service
log_message "info" "Starting bluetooh service..."
sudo systemctl enable bluetooth --now

# Copy wallpapers 
log_message "info" "Copying wallpapers to /usr/share/backgrounds..."
sudo mkdir -p /usr/share/backgrounds
sudo cp -aR wallpapers/* /usr/share/backgrounds/


# Create default user home directories
log_message "info" "Creating default user home directories..."
if ! test -f  "$HOME/.config/user-dirs.dirs" ; then
    xdg-user-dirs-update
    mkdir -p $HOME/.ssh $HOME/.kube $HOME/.aws $HOME/.themes $HOME/.icons $HOME/.local/bin
else 
    log_message "info" "User home directories exists. Skipping creation..."
fi
sleep 2

# Copy config folders
# NEED TO IMPLEMENT SOME BACKUP BEFORE INSTALL THAT CUSTOMS FILES
cp -R config/* $HOME/.config/

# Copy bin/ scripts/binaries
cp -R bin/* $HOME/.local/bin
chmod +x $HOME/.local/bin/*

# # Function to clean tmp directories
clean(){
  log_message "warning" "Cleaning $1"
  sudo rm -rf "$1"
}

# Install paru for AUR packages
log_message "info" "Installing paru AUR package manaer..."

if ! command -v "paru" &> /dev/null ; then 
    tmpdir=$(mktemp -d)
    cd "$tmpdir"
    git clone https://aur.archlinux.org/paru-bin.git
    cd paru-bin || exit
    makepkg -si --noconfirm
    clean "$tmpdir"
else
    log_message "info" "Command exists. Skipping installation..."
fi

# Install other packages with paru
log_message "info" "Installing some packages from AUR..."
paru -Sccd mkdocs mkdocs-rss-plugin mkdocs-material web-greeter-theme-shikai ttf-font-awesome simplescreenrecorder tfenv brave-bin google-chrome slack-desktop gitleaks procs gosec --skipreview --noconfirm --needed

# Setup fish shell
log_message "info" "Setup fish shell..."
sudo chsh -s "$(which fish)" "${USERNAME}"
[ -f "$HOME"/.config/fish/config.fish ] && cp "$HOME"/.config/fish/config.fish "$HOME"/.config/fish/config.fish.bak
# Setup fish config
cp misc/config.fish "$HOME"/.config/fish/config.fish
cp misc/aws-profile.fish "$HOME/.config/fish/functions/"
cp misc/tfsum.fish "$HOME/.config/fish/functions/"
[ ! -d "$HOME"/.local/share/omf ] && curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
# Setup plugins 
#./scripts/fish.sh


log_message "info" "Installing blackarch repository..."
if pacman -Slq | grep -q blackarch; then
    log_message "info" "Blackarch repository already installed. Skipping installation..."
else
    tmpdir=$(mktemp -d)
    cd "$tmpdir"
    curl -O https://blackarch.org/strap.sh
    chmod +x strap.sh
    sudo ./strap.sh
    clean "$tmpdir"
fi

# Install eww
if ! command -v "eww" &> /dev/null ; then 
    tmpdir=$(mktemp -d)
    cd "$tmpdir"
    git clone https://github.com/elkowar/eww
    cd eww
    cargo build --release --no-default-features --features x11
    sudo install -m 755 "target/release/eww" -t /usr/bin/
    clean "$tmpdir"
else
    log_message "info" "Command eww exists. Skipping installation..."
fi

# Setup shikai theme
log_message "info" "Setting up shikai lightdm theme..."
# Backup existing config
sudo cp /etc/lightdm/lightdm.conf /etc/lightdm/lightdm.conf.bak
sudo cp /etc/lightdm/web-greeter.yml /etc/lightdm/web-greeter.yml.bak
sudo sed -i 's/theme: .*/theme: shikai/' /etc/lightdm/web-greeter.yml
sudo sed -i 's/.*greeter-session=.*/greeter-session=web-greeter/g' /etc/lightdm/lightdm.conf
sudo sed -i 's/background_images_dir: .*/background_images_dir: \/usr\/share\/backgrounds/' /etc/lightdm/web-greeter.yml
sudo sed -i 's/logo_image: .*/logo_image: \/usr\/share\/web-greeter\/themes\/shikai\/assets\/media\/logos/' /etc/lightdm/web-greeter.yml
cp assets/arch-logo.png "$HOME/.face"

# Necessary groups for my user
sudo usermod -aG video,input,audio,storage,optical,lp,scanner,users "$USERNAME"

# Hibernation and sleep for autolock
# /etc/systemd/logind.conf
# change --> IdleAction

# Fc cache
fc-cache -fv

# Change MAC address
sudo cp misc/macspoof@.service /etc/systemd/system/macspoof@.service
sudo systemctl enable macspoof@wlp58s0.service

# GTK theme
#https://www.gnome-look.org/p/1267246
# cp -R misc/Nordic-darker misc/Nordic-darker-v40 misc/Nordic-Folders "$HOME/.themes"
# gsettings set org.gnome.desktop.interface gtk-theme Nordic-darker
# gsettings set org.gnome.desktop.wm.preferences theme Nordic-darker
# gsettings set org.gnome.shell.extensions.user-theme name "Nordic-darker"

# VSCODE extensions
log_message "info" "Installing vscode extensions..."
./scripts/vscode-extensions.sh

# Setup
# For the end of the script
sudo systemctl enable lightdm.service --now
