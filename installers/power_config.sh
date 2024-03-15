#! /bin/bash

set -euo pipefail
source installers/logger.sh

############### ACPID ###############
log_message "info" "Setup acpid events"
sudo cp etc/acpi/events/* /etc/acpi/events/
sudo chmod 755 etc/acpi/*.sh
sudo cp etc/acpi/*.sh /etc/acpi/
sudo systemctl restart acpid
############### ACPID ###############