#! /usr/bin/env bash

clean(){
  log_message "warning" "Cleaning $1"
  sudo rm -rf "$1"
}

# Packages from official repos
sudo pacman -Sy --noconfirm --needed podman-dnsname podman-docker aardvark-dns netavark podman podman-compose terragrunt aws-cli-v2 kubectl helm go minikube

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

# Symlinks for docker, better than creating an alias (in scripting alias will not work)
sudo ln -s $(which podman-compose) /usr/bin/docker-compose
sudo ln -s $(which podman) /usr/bin/docker

#curl -L https://raw.githubusercontent.com/warrensbox/tgswitch/release/install.sh | sudo bash
#paru -Scc
paru -S golangci-lint tfenv kubectx --skipreview --noconfirm --needed

# Setup tfenv
sudo usermod -aG tfenv ${USER}
sudo tfenv install 1.5.5 # latest version without BSL
sudo tfenv use 1.5.5

# Install kubecolor from the official github release link (the repo is public archive)
if ! command -v "kubecolor" &> /dev/null ; then
  mkdir /tmp/kubecolor
  curl -L --fail --remote-name-all https://github.com/hidetatz/kubecolor/releases/download/v0.0.25/kubecolor_0.0.25_Linux_x86_64.tar.gz -o /tmp/kubecolor/kubecolor.tar.gz
  cd /tmp/kubecolor && tar -xvf kubecolor.tar.gz
  sudo install -o root -g root -m 0755 kubecolor /usr/local/bin/kubecolor
  cd "$HOME"
  sudo rm -rvf /tmp/kubecolor
fi


# Install custom tools I created for terraform, or to fetch ~/.aws/credentials
if ! command -v "aws-sso-auth" &> /dev/null ; then
  curl --proto '=https' --tlsv1.2 -sSfL https://raw.githubusercontent.com/containerscrew/aws-sso-auth/main/scripts/install.sh | bash
fi

if ! command -v "tftools" &> /dev/null ; then
  curl --proto '=https' --tlsv1.2 -sSfL https://raw.githubusercontent.com/containerscrew/tftools/main/scripts/install.sh | bash
fi

# Some Golang stuff
#go install -v golang.org/x/tools/gopls@latest

if ! command -v "goimports" &> /dev/null ; then
  go install golang.org/x/tools/cmd/goimports@latest
fi
