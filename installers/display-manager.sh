#! /bin/bash

set -euo pipefail
source installers/logger.sh

############### DISPLAY MANAGER ###############
sudo systemctl enable lightdm.service
log_message "info" "Configure lightdm webkit2 theme"
sudo sed -i 's/.*greeter-session=.*/greeter-session=web-greeter/g' /etc/lightdm/lightdm.conf
sudo sed -i 's/theme: .*/theme: neon/' /etc/lightdm/web-greeter.yml
#sudo sed -i 's/background_images_dir: .*/background_images_dir: \/usr\/share\/backgrounds/' /etc/lightdm/web-greeter.yml
cp assets/arch-logo.png /usr/share/icons/arch-logo.png
cp assets/daniels-archlinux.png /usr/share/icons/daniels-archlinux.png
log_message "info" "Now, remember to configure your lightdm theme manually in the login screen"
#sudo systemctl restart lightdm
############### DISPLAY MANAGER ###############
