#! /bin/bash

# Don't run this script as root
if [ "$(id -u)" = 0 ]; then
    echo "This script MUST NOT be run as root user."
    exit 1
fi

# Stop script if errors
set -eu

############### SOURCE FILES ###############
source ./installers/banner.sh
source ./installers/logger.sh
############### SOURCE FILES ###############

############### BANNER ###############
print_ascii_banner
############### BANNER ###############

############### SYSTEM PACKAGES ###############
log_message "info" "Installing packages"
./installers/packages.sh
############### SYSTEM PACKAGES ###############

############### CORE CONFIG ###############
log_message "info" "Core configurations"
./installers/core_config.sh
############### CORE CONFIG ###############

############### USER CONFIG ###############
log_message "info" "User configurations"
./installers/user_config.sh
############### USER CONFIG ###############


log_message "info" "Now, if it's your first installation, reboot the system or run $ sudo systemctl restart lightdm"
