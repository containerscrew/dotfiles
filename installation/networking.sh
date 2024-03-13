#! /bin/bash

set -euo pipefail
source installation/logger.sh

############### UFW ###############
log_message "info" "Setup firewall using ufw..."
sudo systemctl enable ufw --now
sudo ufw allow 22/tcp
sudo ufw --force enable
############### UFW ###############

############### MAC ADDRESS ###############
log_message "info" "Setup macspoof..."
sudo cp misc/macspoof@.service /etc/systemd/system/macspoof@.service
interface_name=$(ip link show | grep wl | awk '{print $2}' | sed 's/.$//')
sudo systemctl enable macspoof@"$interface_name".service
############### MAC ADDRESS ###############