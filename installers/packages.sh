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
# Refresh sudo session
sudo -v

# Check if packages.txt exists
if [[ ! -f packages.txt ]]; then
    echo "Error: packages.txt file not found."
    exit 1
fi

# Read all packages into an array
mapfile -t packages < packages.txt

# Install all packages in one command, capturing errors
echo "Installing packages..."
if ! sudo pacman -S --noconfirm --needed "${packages[@]}" 2> install_errors.log; then
    echo "Error: Some packages failed to install."
    echo "Details of the error(s):"
    cat install_errors.log
    exit 1
fi

# Keep this by the moment for nvidia drivers
# https://github.com/lutris/docs/blob/master/InstallingDrivers.md
#sudo pacman -S --noconfirm --needed nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader
#
#sudo pacman -S --noconfirm --needed lib32-mesa vulkan-intel lib32-vulkan-intel vulkan-icd-loader lib32-vulkan-icd-loader
#
#log_message "info" "Installing paru packages"
#paru -S --skipreview --noconfirm --needed jetbrains-toolbox coreimage qtile-extras python-pulsectl-asyncio mkdocs \
#        mkdocs-rss-plugin mkdocs-material slack-desktop gitleaks procs gosec aws-session-manager-plugin  \
#        ttf-font-awesome insomnia ttf-gentium-basic golangci-lint kubectx terraform-docs \
#        podman-dnsname tfenv kubecolor calcurse todotxt playerctl zoom usbimager \
#        aws-cli-v2 notion-app-electron android-sdk-cmdline-tools-latest hey \
#        android-tools dracula-gtk-theme visual-studio-code-bin rustscan balena-etcher krew rofi-autorandr \
#        insomnia mongodb-compass youtube-dl helm-docs eww shell-color-scripts-git hubble-bin oryx \
#        hadolint-bin python-pytest exercism-bin bpftool-bin bpftrace teams pdftk terraform-ls tflint terraform-lsp
#
## Clean paru cache
#log_message "info" "Cleaning paru cache"
#paru -Sccd --skipreview --noconfirm
#
#log_message "info" "Install terragrunt"
#paru -S --skipreview --noconfirm --needed terragrunt
#
#log_message "info" "Install custom tools"
#command -v tftools >/dev/null 2>&1 || curl --proto '=https' --tlsv1.2 -sSfL https://raw.githubusercontent.com/containerscrew/tftools/main/scripts/install.sh | bash

#log_message "info" "Install helm plugins"
#helm plugin install https://github.com/helm/helm-mapkubeapis || true
