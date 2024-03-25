#! /bin/bash

set -euo pipefail
source installers/logger.sh

############### DISPLAY MANAGER ###############
sudo systemctl enable lightdm.service
log_message "info" "Setting up shikai lightdm webkit2 theme"
sudo sed -i 's/theme: .*/theme: shikai/' /etc/lightdm/web-greeter.yml
sudo sed -i 's/.*greeter-session=.*/greeter-session=web-greeter/g' /etc/lightdm/lightdm.conf
sudo sed -i 's/background_images_dir: .*/background_images_dir: \/usr\/share\/backgrounds/' /etc/lightdm/web-greeter.yml
sudo sed -i 's/logo_image: .*/logo_image: \/usr\/share\/web-greeter\/themes\/shikai\/assets\/media\/logos/' /etc/lightdm/web-greeter.yml
cp assets/arch-logo.png "$HOME/.face"
sudo systemctl restart lightdm
############### DISPLAY MANAGER ###############