#! /bin/bash

set -euo pipefail
source ./installers/logger.sh
source ./installers/helpers.sh
source ./installers/banner.sh

print_ascii_banner "Running core_config.sh"

if [ "$(id -u)" = 0 ]; then
    echo "This script MUST NOT be run as root user."
    exit 1
fi

log_message "info" "Setup /etc/hosts"
sudo rsync -avzhu etc/hosts /etc/hosts
sudo chmod 644 /etc/hosts

log_message "info" "Setup firewall using ufw"
log_message "info" "If you want to enable, for example, ssh, run 'sudo ufw allow ssh'"
sudo systemctl enable ufw --now
sudo ufw default deny incoming
sudo ufw --force enable

log_message "info" "Setup macspoof"
sudo cp etc/systemd/system/macspoof@.service /etc/systemd/system/macspoof@.service
interface=$(ip link show | grep wl | awk '{print $2}' | sed 's/.$//' | awk 'NR==1')
log_message "info" "Enable macspoof service for $interface"
sudo systemctl enable macspoof@"$interface".service

log_message "info" "Setup systemd-resolved"
sudo ln -sf ../run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
sudo systemctl enable --now systemd-resolved

log_message "info" "Copy work VPN to /etc/vpnc/work.conf"
sudo rsync -avzhu --backup --suffix="$(date +'.%F_%H-%M')" etc/vpnc/work.conf /etc/vpnc/work.conf

# log_message "info" "Setup logind.conf"
# sudo sed -i '/^#HandleLidSwitch=/s/^#//; /^HandleLidSwitch=/s/=.*/=suspend/' /etc/systemd/logind.conf
# sudo sed -i '/^#IdleAction=/s/^#//; /^IdleAction=/s/=.*/=lock/' /etc/systemd/logind.conf
# sudo systemctl restart systemd-logind

log_message "info" "Enable bluetooth service"
sudo systemctl enable bluetooth --now

log_message "info" "Setup podman container runtime"
sudo cp -a etc/containers/registries.conf.d/podman-config.conf /etc/containers/registries.conf.d/podman-config.conf
sudo mkdir -p /etc/docker
sudo cp -a etc/docker/daemon.json /etc/docker/daemon.json
log_message "info" "Nvidia container toolkit"
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl enable docker --now
sudo usermod -aG docker dcr

log_message "info" "Setup grub theme"
if [ -e /boot/grub/themes/dedsec/theme.txt ]; then
    log_message "warning" "DedSec theme already installed. Skipping..."
else
    unzip -o wrench-1080p.zip -d /tmp/
    sudo cp -r /tmp/dedsec /boot/grub/themes
    sudo sed -i 's/^#GRUB_THEME=.*/GRUB_THEME="\/boot\/grub\/themes\/dedsec\/theme.txt"/' /etc/default/grub
    sudo sed -i '/GRUB_CMDLINE_LINUX_DEFAULT/ s/quiet"/quiet splash"/' /etc/default/grub
    sudo grub-mkconfig -o /boot/grub/grub.cfg
fi

#### OLD THEME ####
#wget https://github.com/voidlhf/StarRailGrubThemes/raw/master/themes/RuanMei.tar.gz -P /tmp
#tar -xzf /tmp/RuanMei.tar.gz -C /tmp
#sudo cp -r /tmp/RuanMei /boot/grub/themes/
#sudo sed -i 's/^#GRUB_THEME=.*/GRUB_THEME="\/boot\/grub\/themes\/RuanMei\/theme.txt"/' /etc/default/grub
#sudo sed -i '/GRUB_CMDLINE_LINUX_DEFAULT/ s/quiet"/quiet splash"/' /etc/default/grub
#sudo grub-mkconfig -o /boot/grub/grub.cfg
#rm -rf /tmp/RuanMei*

log_message "info" "Setup ligthdm"
sudo cp etc/lightdm/lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf
sudo systemctl enable lightdm.service