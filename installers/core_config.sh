#! /bin/bash

set -euo pipefail
source installers/logger.sh

############### ETC HOSTS ###############
log_message "info" "Setup /etc/hosts"
sudo rsync -avzhu --backup --suffix="$(date +'.%F_%H-%M')" etc/hosts /etc/hosts
sudo chmod 644 /etc/hosts
############### ETC HOSTS ###############

############### BLUETOOTH ###############
log_message "info" "Enable bluetooth service"
sudo systemctl enable bluetooth --now
############### BLUETOOTH ###############

############### PODMAN CONTAINER RUNTIME ###############
log_message "info" "Setup podman container runtime"
sudo cp -a misc/podman-config.conf /etc/containers/registries.conf.d/podman-config.conf
sudo systemctl enable podman
sudo systemctl restart podman
# Symlinks for docker, better than creating an alias (in scripting alias will not work)
sudo ln -fs "$(which podman-compose)" /usr/bin/docker-compose
sudo ln -fs "$(which podman)" /usr/bin/docker
############### PODMAN CONTAINER RUNTIME ###############