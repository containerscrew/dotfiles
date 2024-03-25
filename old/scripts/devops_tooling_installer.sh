#! /usr/bin/env bash

clean(){
  log_message "warning" "Cleaning $1"
  sudo rm -rf "$1"
}

# Enable services
#sudo systemctl enable --now podman.socket

# rootless: export DOCKER_HOST=unix:///run/user/$UID/podman/podman.sock
# systemctl --user enable --now podman.socket
# $XDG_RUNTIME_DIR/podman/podman.sock:/var/run/docker.sock

# IMPORTANT. Resolving problems with DNS resolutions:
#$ podman info | grep network
#  networkBackend: netavark

# Add your registries to unquialified-search-registries, in /etc/containers/registries.conf
# Edit /etc/containers/containers.conf if needed to add the correct network
# [network]

# Explicitly use netavark. See https://github.com/containers/podman-compose/issues/455
# network_backend = "netavark"
#podman system reset --force


#curl -L https://raw.githubusercontent.com/warrensbox/tgswitch/release/install.sh | sudo bash
# Some Golang stuff
#go install -v golang.org/x/tools/gopls@latest

if ! command -v "goimports" &> /dev/null ; then
  go install golang.org/x/tools/cmd/goimports@latest
fi

go install github.com/reugn/wifiqr/cmd/wifiqr@latest
