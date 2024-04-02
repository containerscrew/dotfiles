#! /bin/bash

set -euo pipefail
source installers/logger.sh

user_dirs=(
".ssh"
".kube"
".themes"
".aws"
".icons"
".local/bin"
"Documents/Code"
"Documents/Code/Work"
"Documents/Code/Personal"
"Documents/Private"
"Documents/Books"
)

log_message "info" "Adding $USER to some groups"
sudo usermod -aG video,input,audio,storage,optical,lp,scanner,users "$USER"

log_message "info" "Creating default user home directories"
if ! test -f  "$HOME/.config/user-dirs.dirs" ; then
    xdg-user-dirs-update
else
    log_message "info" "User home directories exists. Skipping creation"
fi

log_message "info" "Creating custom user directories"
for dir in "${user_dirs[@]}"; do
  mkdir -p "$HOME/$dir"
done

log_message "info" "Copying custom binaries to ~/.local/bin"
cp -R bin/* "$HOME"/.local/bin
chmod +x "$HOME"/.local/bin/*

log_message "info" "Adding new custom path file to /etc/profile.d/"
sudo cp etc/profile.d/custom-path.sh /etc/profile.d/custom-path.sh

log_message "info" "Copying ~/.config files"
sudo rsync -avzhu --backup --suffix="$(date +'.%F_%H-%M')" config/* "$HOME"/.config/

log_message "info" "Setup zsh shell as a default shell for user $USER"
sudo chsh -s "$(which zsh)" "$USER"

#log_message "info" "Setup oh my zsh"
if [ ! -d "$HOME/.oh-my-zsh" ]; then sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; fi
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions; fi
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting; fi

log_message "info" "Copying custom .zshrc"
sudo rsync -avzhu --backup --suffix="$(date +'.%F_%H-%M')" zsh/.zshrc "$HOME"/.zshrc

log_message "info" "Copying wallpapers to /usr/share/backgrounds..."
sudo mkdir -p /usr/share/backgrounds
sudo cp -ar wallpapers/* /usr/share/backgrounds/

log_message "info" "FC cache"
fc-cache -fv