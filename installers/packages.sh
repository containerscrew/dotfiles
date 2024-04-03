#! /bin/bash

set -euo pipefail
source installers/logger.sh

origin_dir="$PWD"

check_binary() {
    binary="$1"
    if ! command -v "$binary" &> /dev/null; then
        log_message "warning" "$binary not found in system, will be installed!"
        return 1
    else
        log_message "warning" "Binary $binary exists. Do you want to reinstall it? [y/n] (default n with 2s of timeout)"
        read -t 2 answer

        if [ -z "$answer" ]; then
          answer="n"
        fi

        if [ "$answer" == "y" ]; then
          return 1
        else
          log_message "info" "Skipping installation of $binary"
        fi
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
            bluez bluez-utils zsh arandr xorg-server xorg-xinit \
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
            npm ufw nmap acpid terminator podman-docker \
            aardvark-dns netavark podman podman-compose aws-cli-v2 \
            kubectl helm go minikube xorg-server-xephyr python-netifaces \
            chromium github-cli grub-customizer xorg-xhost lxqt-policykit

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
paru -S --skipreview --noconfirm --needed jetbrains-toolbox coreimage qtile-extras python-pulsectl-asyncio mkdocs \
        mkdocs-rss-plugin mkdocs-material slack-desktop gitleaks procs gosec aws-session-manager-plugin  \
        ttf-font-awesome brave-bin insomnia ttf-gentium-basic golangci-lint kubectx terraform-docs \
        podman-dnsname tfenv web-greeter-theme-shikai kubecolor

# Clean paru cache
paru -Sccd --skipreview --noconfirm

#log_message "info" "Setup tfenv"
#sudo usermod -aG tfenv "${USER}"
#sudo tfenv install 1.5.5
#sudo tfenv use 1.5.5

log_message "info" "Install terragrunt"
paru -S --skipreview --noconfirm --needed terragrunt

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

# EWW for widgets
if ! check_binary "eww"; then
    tmpdir=$(mktemp -d)
    cd "$tmpdir"
    git clone https://github.com/elkowar/eww
    cd eww
    cargo build --release --no-default-features --features x11
    sudo install -m 755 "target/release/eww" -t /usr/bin/
    clean "$tmpdir"
fi

# NPM packages
if ! check_binary "doctoc"; then
  cd "$origin_dir"
  sudo npm install -g doctoc
fi

########## Custom tools ##########
if ! check_binary "aws-sso-auth"; then
  curl --proto '=https' --tlsv1.2 -sSfL https://raw.githubusercontent.com/containerscrew/aws-sso-auth/main/scripts/install.sh | bash
fi

if ! check_binary "tftools"; then
  curl --proto '=https' --tlsv1.2 -sSfL https://raw.githubusercontent.com/containerscrew/tftools/main/scripts/install.sh | bash
fi

if ! check_binary "hey"; then
  sudo wget https://hey-release.s3.us-east-2.amazonaws.com/hey_linux_amd64 -O /usr/local/bin/hey
  sudo chmod +x /usr/local/bin/hey
fi

if ! check_binary "colorscript"; then
    tmpdir=$(mktemp -d)
    cd "$tmpdir"
    git clone https://gitlab.com/dwt1/shell-color-scripts.git
    cd shell-color-scripts
    sudo make install
    clean "$tmpdir"
    cd "$origin_dir"
fi

if ! check_binary "hadolint"; then
    sudo wget -O /usr/local/bin/hadolint https://github.com/hadolint/hadolint/releases/download/v2.12.0/hadolint-Linux-x86_64
fi

#https://github.com/aws/amazon-ec2-instance-selector/releases/tag/v2.4.1
########## Custom tools ##########
