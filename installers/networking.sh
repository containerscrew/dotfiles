#! /bin/bash

set -euo pipefail
source installers/logger.sh
source installers/helpers.sh

############### UFW ###############
log_message "info" "Setup firewall using ufw"
sudo systemctl enable ufw --now
sudo ufw allow 22/tcp
sudo ufw --force enable
############### UFW ###############

############### MAC ADDRESS ###############
log_message "info" "Setup macspoof"
sudo cp misc/macspoof@.service /etc/systemd/system/macspoof@.service
interface_name=$(ip link show | grep wl | awk '{print $2}' | sed 's/.$//')
sudo systemctl enable macspoof@"$interface_name".service
############### MAC ADDRESS ###############

############### systemd-resolved ###############
log_message "info" "Setup systemd-resolved"
sudo ln -sf ../run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
sudo systemctl enable --now systemd-resolved
############### systemd-resolved ###############


############### WORK VPN ###############
log_message "info" "Copy work VPN to /etc/vpnc/work.conf"
#diff_files misc/work.conf /etc/vpnc/work.conf
sudo rsync -avzhu --backup --suffix="$(date +'.%F_%H-%M')" misc/work.conf /etc/vpnc/work.conf
#sudo cp -u misc/work.conf /etc/vpnc/work.conf
############### WORK VPN ###############

