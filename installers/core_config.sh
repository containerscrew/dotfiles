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
sudo ufw allow ssh
sudo systemctl enable ufw --now
sudo ufw default deny incoming
sudo ufw --force enable

log_message "info" "Setup macspoof"
sudo cp etc/systemd/system/macspoof@.service /etc/systemd/system/macspoof@.service
interface=$(ip link show | grep wl | awk '{print $2}' | sed 's/.$//' | awk 'NR==1')
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
sudo systemctl enable docker --now
sudo usermod -aG docker dcr

log_message "info" "Setup grub theme"
wget https://github.com/voidlhf/StarRailGrubThemes/raw/master/themes/RuanMei.tar.gz -P /tmp
tar -xzf /tmp/RuanMei.tar.gz -C /tmp
sudo cp -r /tmp/RuanMei /boot/grub/themes/
sudo sed -i 's/^#GRUB_THEME=.*/GRUB_THEME="\/boot\/grub\/themes\/RuanMei\/theme.txt"/' /etc/default/grub
sudo sed -i '/GRUB_CMDLINE_LINUX_DEFAULT/ s/quiet"/quiet splash"/' /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg
rm -rf /tmp/RuanMei*

log_message "info" "Setup lightdm"
sudo systemctl enable lightdm.service
# log_message "info" "Configure lightdm webkit2 theme"
sudo sed -i 's/.*greeter-session=.*/greeter-session=web-greeter/g' /etc/lightdm/lightdm.conf
# sudo cp -ar assets/arch-logo.png /usr/share/icons/arch-logo.png
sudo sed -i 's/theme: .*/theme: shikai/' /etc/lightdm/web-greeter.yml
# #sudo sed -i 's/background_images_dir: .*/background_images_dir: \/usr\/share\/backgrounds/' /etc/lightdm/web-greeter.yml
# sudo cp assets/arch-logo.png /usr/share/icons/arch-logo.png
# sudo cp assets/daniels-archlinux.png /usr/share/icons/daniels-archlinux.png
# log_message "info" "Now, remember to configure your lightdm theme manually in the login screen"
#sudo systemctl restart lightdm

log_message "info" "Nvidia graphics configuration"
# for module in $NVIDIA_MODULES; do
#   sudo sed -i "/^MODULES=/!b; s/(\(.*\)${module}\(.*\))/(\1\2/; s/MODULES=(/&${module} /" /etc/mkinitcpio.conf
# done
# sudo mkinitcpio -P
# sudo nvidia-xconfig
# sudo sed -i '/^GRUB_CMDLINE_LINUX_DEFAULT=/d' /etc/default/grub
# echo "$GRUB_CMDLINE_LINUX_DEFAULT" | sudo tee -a /etc/default/grub
# sudo grub-mkconfig -o /boot/grub/grub.cfg
