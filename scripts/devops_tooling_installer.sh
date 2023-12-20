#! /usr/bin/env bash

clean(){
  log_message "warning" "Cleaning $1"
  sudo rm -rf "$1"
}

# Packages from official repos
sudo pacman -Sy --noconfirm --needed podman podman-compose terragrunt aws-cli-v2 kubectl helm go minikube 

#curl -L https://raw.githubusercontent.com/warrensbox/tgswitch/release/install.sh | sudo bash
paru -S tfenv --skipreview --noconfirm --needed

# Setup version
sudo tfenv install 1.5.5 # latest version without BSL
sudo tfenv use 1.5.5

# Install kubecolor from the official github release link (the repo is public archive)
mkdir /tmp/kubecolor
curl -L --fail --remote-name-all https://github.com/hidetatz/kubecolor/releases/download/v0.0.25/kubecolor_0.0.25_Linux_x86_64.tar.gz -o /tmp/kubecolor/kubecolor.tar.gz
cd /tmp/kubecolor && tar -xvf kubecolor.tar.gz 
sudo install -o root -g root -m 0755 kubecolor /usr/local/bin/kubecolor
cd "$HOME"
sudo rm -rvf /tmp/kubecolor



# Install custom tools I created for terraform, or to fetch ~/.aws/credentials
curl --proto '=https' --tlsv1.2 -sSfL https://raw.githubusercontent.com/containerscrew/aws-sso-auth/main/scripts/install.sh | bash
curl --proto '=https' --tlsv1.2 -sSfL https://raw.githubusercontent.com/containerscrew/tftools/main/scripts/install.sh | bash

# Some Golang stuff
#go install -v golang.org/x/tools/gopls@latest