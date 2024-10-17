#! /bin/bash

set -euo pipefail
source ./installers/logger.sh
source ./installers/banner.sh

origin_dir="$PWD"

print_ascii_banner "Running packages.sh"

if [ "$(id -u)" = 0 ]; then
    echo "This script MUST NOT be run as root user."
    exit 1
fi

# check_binary() {
#     binary="$1"
#     if ! command -v "$binary" &> /dev/null; then
#         log_message "warning" "$binary not found in system, will be installed!"
#         return 1
#     else
#         log_message "warning" "Binary $binary exists. Do you want to reinstall it? [y/n] (default n with 2s of timeout)"
#         read -t 2 answer

#         if [ -z "$answer" ]; then
#           answer="n"
#         fi

#         if [ "$answer" == "y" ]; then
#           return 1
#         else
#           log_message "info" "Skipping installation of $binary"
#         fi
#         return 0
#     fi
# }

# clean(){
#   log_message "warning" "Cleaning $1"
#   sudo rm -rf "$1"
# }

## Install additional repositories
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

log_message "info" "Installing pacman packages"
sudo pacman -Syu --noconfirm --needed base-devel rustup picom \
            dunst feh alacritty jq git papirus-icon-theme rofi \
            xorg-xprop xorg-xkill xorg-xsetroot xorg-xwininfo xorg-xrandr \
            xdg-user-dirs plymouth plymouth-themes neovim mlocate \
            bluez bluez-utils zsh arandr xorg-server xorg-xinit \
            curl wget neofetch lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings \
            blueman firefox conky mlocate ngrep lsd bat light-locker \
            ttf-jetbrains-mono ttf-jetbrains-mono-nerd ttf-terminus-nerd ttf-inconsolata ttf-joypixels \
            fzf brightnessctl man webp-pixbuf-loader dmidecode \
            net-tools inetutils ttf-nerd-fonts-symbols htop nautilus discord openvpn veracrypt \
            keepass pluma pamixer python3 python-pip shutter signal-desktop qpwgraph \
            pipewire pipewire-pulse pavucontrol xbindkeys ttf-firacode-nerd wireguard-tools \
            systemd-resolvconf macchanger tcpdump imagemagick vpnc whois qemu-full virt-manager \
            qtile python-pywlroots xorg-xwayland rsync python-dbus-next python-iwlib \
            traceroute pre-commit goreleaser noto-fonts-emoji noto-fonts-extra \
            nyx udiskie ntfs-3g network-manager-applet volumeicon cbatticon \
            gnome-calendar spotify-launcher libpwquality dnsutils cryptsetup \
            gparted gnome-disk-utility tumbler vlc ffmpeg torbrowser-launcher \
            starship unzip vi gtk4 peek vlc flameshot python-boto3 \
            tmux xclip xfce4-power-manager pass geeqie websocat \
            npm ufw nmap acpid terminator cilium-cli \
            aardvark-dns netavark podman podman-compose \
            kubectl helm go minikube xorg-server-xephyr python-netifaces \
            chromium github-cli grub-customizer xorg-xhost polkit-gnome \
            xorg-xinput conky-manager fuse-overlayfs \
            mariadb-clients oath-toolkit nushell btop \
            gnome-calculator docker python-kubernetes python-hatch \
            exfat-utils evince python-pipx lxappearance kvantum-qt5 \
            hugo bcc bcc-tools python-bcc bpf bpf-linker vim cmake clang llvm flex bison linux-api-headers \
            buildah sqlitebrowser gnome-keyring \
            docker-compose telegram-desktop glow obs-studio hwinfo eog \
            ansible buildkit docker-buildx mkcert mingw-w64 virtualbox virtualbox-guest-utils virtualbox-host-modules-arch \
            sshpass python-pyopenssl python-kubernetes steam virt-manager \
            kompose accountsservice autorandr jupyterlab xorg-xbacklight \
            musl musl-aarch64 transmission-gtk paru whatweb python-poetry \
            nvtop cuda cuda-tools vulkan-tools \
            linux-headers python-pyroute2 solaar strace hdparm libreoffice ripgrep \
            python-tensorflow-cuda nvidia-container-toolkit clipcat python-notify2 python-daemon || true


# Keep this by the moment for nvidia drivers
# https://github.com/lutris/docs/blob/master/InstallingDrivers.md
sudo pacman -S --noconfirm --needed nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader

sudo pacman -S --noconfirm --needed lib32-mesa vulkan-intel lib32-vulkan-intel vulkan-icd-loader lib32-vulkan-icd-loader

log_message "info" "Installing paru packages"
paru -S --skipreview --noconfirm --needed jetbrains-toolbox coreimage qtile-extras python-pulsectl-asyncio mkdocs \
        mkdocs-rss-plugin mkdocs-material slack-desktop gitleaks procs gosec aws-session-manager-plugin  \
        ttf-font-awesome insomnia ttf-gentium-basic golangci-lint kubectx terraform-docs \
        podman-dnsname tfenv kubecolor calcurse todotxt playerctl zoom \
        aws-cli-v2 web-greeter notion-app-electron android-sdk-cmdline-tools-latest \
        android-tools dracula-gtk-theme visual-studio-code-bin rustscan balena-etcher krew rofi-autorandr \
	insomnia mongodb-compass youtube-dl helm-docs eww shell-color-scripts-git hubble-bin \
        hadolint-bin python-pytest exercism-bin bpftool-bin bpftrace teams renovate pdftk terraform-ls tflint terraform-lsp

# Clean paru cache
log_message "info" "Cleaning paru cache"
paru -Sccd --skipreview --noconfirm

log_message "info" "Install terragrunt"
paru -S --skipreview --noconfirm --needed terragrunt

log_message "info" "Install custom tools"
command -v tftools >/dev/null 2>&1 || curl --proto '=https' --tlsv1.2 -sSfL https://raw.githubusercontent.com/containerscrew/tftools/main/scripts/install.sh | bash

log_message "info" "Install helm plugins"
helm plugin install https://github.com/helm/helm-mapkubeapis || true
