#! /bin/bash

set -euo pipefail
source installers/logger.sh

check_binary() {
    binary="$1"
    if ! command -v "$binary" &> /dev/null; then
        log_message "error" "$binary not found in system, install it!"
        return 1
    else
        log_message "info" "Command $binary exists. Skipping installation"
        return 0
    fi
}

clean(){
  log_message "warning" "Cleaning $1"
  sudo rm -rf "$1"
}

log_message "info" "Installing pacman packages"
sudo pacman -Syu --noconfirm --needed base-devel rustup picom \
            dunst feh alacritty jq git papirus-icon-theme rofi \
            xorg-xprop xorg-xkill xorg-xsetroot xorg-xwininfo xorg-xrandr \
            xdg-user-dirs plymouth neovim vscode mlocate \
            bluez bluez-utils fish arandr xorg-server xorg-xinit \
            curl wget neofetch lightdm lightdm-gtk-greeter lightdm-webkit2-greeter \
            blueman firefox conky mlocate ngrep lsd bat \
            ttf-jetbrains-mono ttf-jetbrains-mono-nerd ttf-terminus-nerd ttf-inconsolata ttf-joypixels \
            fzf brightnessctl man webp-pixbuf-loader light-locker \
            net-tools inetutils ttf-nerd-fonts-symbols htop nautilus discord openvpn veracrypt \
            keepass pluma bitwarden pamixer python3 python-pip shutter signal-desktop qpwgraph \
            pipewire pipewire-pulse pavucontrol xbindkeys ttf-firacode-nerd wireguard-tools \
            systemd-resolvconf macchanger tcpdump imagemagick vpnc whois qemu-full virt-manager \
            qtile xorg-xwayland rsync python-dbus-next python-iwlib \
            traceroute pre-commit goreleaser noto-fonts-emoji noto-fonts-extra \
            nyx udiskie ntfs-3g network-manager-applet volumeicon cbatticon \
            gnome-calendar spotify-launcher libpwquality dnsutils cryptsetup \
            gparted gnome-disk-utility tumbler vlc ffmpeg torbrowser-launcher \
            starship unzip vi gtk4 peek vlc flameshot python-boto3 \
            tmux xclip xfce4-power-manager pass okular geeqie websocat \
            npm ufw nmap acpid terminator

# Paru for AUR packages
if ! check_binary "paru"; then
    tmpdir=$(mktemp -d)
    cd "$tmpdir"
    git clone https://aur.archlinux.org/paru-bin.git
    cd paru-bin || exit
    makepkg -si --noconfirm
    clean "$tmpdir"
fi

log_message "info" "Installing paru packages"
#-Sccd --skipreview --noconfirm
paru -Sccd --skipreview --noconfirm --needed jetbrains-toolbox coreimage qtile-extras python-pulsectl-asyncio mkdocs \
        mkdocs-rss-plugin mkdocs-material slack-desktop gitleaks procs gosec aws-session-manager-plugin  \
        ttf-font-awesome brave-bin insomnia ttf-gentium-basic


log_message "info" "Installing blackarch repository"
if pacman -Slq | grep -q blackarch; then
    log_message "info" "Blackarch repository already installed. Skipping installation"
else
    tmpdir=$(mktemp -d)
    cd "$tmpdir"
    curl -O https://blackarch.org/strap.sh
    chmod +x strap.sh
    sudo ./strap.sh
    clean "$tmpdir"
fi