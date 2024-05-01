#! /bin/bash

set -euo pipefail
source installers/logger.sh

############### ETC HOSTS ###############
log_message "info" "Setup /etc/hosts"
sudo rsync -avzhu --backup --suffix="$(date +'.%F_%H-%M')" etc/hosts /etc/hosts
sudo chmod 644 /etc/hosts
############### ETC HOSTS ###############

############### LOGIND ###############
log_message "info" "Setup logind.conf"
sudo sed -i '/^#HandleLidSwitch=/s/^#//; /^HandleLidSwitch=/s/=.*/=ignore/' /etc/systemd/logind.conf
sudo sed -i '/^#IdleAction=/s/^#//; /^IdleAction=/s/=.*/=lock/' /etc/systemd/logind.conf
systemctl restart systemd-logind


############### BLUETOOTH ###############
log_message "info" "Enable bluetooth service"
sudo systemctl enable bluetooth --now
############### BLUETOOTH ###############

############### PODMAN CONTAINER RUNTIME ###############
log_message "info" "Setup podman container runtime"
sudo cp -a misc/podman-config.conf /etc/containers/registries.conf.d/podman-config.conf
#sudo systemctl enable podman
#sudo systemctl restart podman
# Symlinks for docker, better than creating an alias (in scripting alias will not work)
#sudo ln -fs "$(which podman-compose)" /usr/bin/docker-compose
#sudo ln -fs "$(which podman)" /usr/bin/docker
############### PODMAN CONTAINER RUNTIME ###############

############### GRUB ###############
#### NOT WORKING!!
log_message "info" "Setup grub theme"
wget https://github.com/voidlhf/StarRailGrubThemes/raw/master/themes/RuanMei.tar.gz -P /tmp
tar -xzf /tmp/RuanMei.tar.gz -C /tmp
sudo cp -r /tmp/RuanMei /boot/grub/themes/
sudo sed -i 's/^#GRUB_THEME=.*/GRUB_THEME="\/boot\/grub\/themes\/RuanMei\/theme.txt"/' /etc/default/grub
sudo sed -i '/GRUB_CMDLINE_LINUX_DEFAULT/ s/quiet"/quiet splash"/' /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg
rm -rf /tmp/RuanMei*
############### GRUB ###############
