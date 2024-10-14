#! /bin/bash

set -euo pipefail
source ./installers/logger.sh
source ./installers/banner.sh

print_ascii_banner "Running user_config.sh"

if [ "$(id -u)" = 0 ]; then
    echo "This script MUST NOT be run as root user."
    exit 1
fi

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
".my_zsh_functions"
)

core_dirs=(
  "/mnt/ssd"
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

log_message "info" "Creating core directories"
for dir in "${core_dirs[@]}"; do
  sudo mkdir -p "$dir"
done

log_message "info" "Copying custom binaries to ~/.local/bin"
cp -R bin/* "$HOME"/.local/bin
chmod +x "$HOME"/.local/bin/*

log_message "info" "Adding new custom path file to /etc/profile.d/"
sudo cp etc/profile.d/custom-path.sh /etc/profile.d/custom-path.sh

log_message "info" "Copying ~/.config files"
rsync -avzhu --backup --suffix="$(date +'.%F_%H-%M')" config/* "$HOME"/.config/
rsync -avzhu misc/.gtkrc-2.0 "$HOME"/.gtkrc-2.0
rsync -avzhu misc/.dmrc "$HOME"/.dmrc
sudo cp assets/arch-logo.png /usr/share/icons/arch-logo.png
echo "export QT_STYLE_OVERRIDE=kvantum" > ~/.profile

log_message "info" "Copying ~/.ssh files"
rsync -avzhu --backup --suffix="$(date +'.%F_%H-%M')" ssh/* "$HOME"/.ssh/

log_message "info" "Setup zsh shell as a default shell for user $USER"
sudo chsh -s "$(which zsh)" "$USER"

log_message "info" "Setup oh my zsh & plugins"
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
if [ ! -d "$HOME/.oh-my-zsh" ]; then sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended; fi
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions; fi
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting; fi

log_message "info" "Copying custom .zshrc and functions"
rsync -avzh zsh/.zshrc "$HOME"/.zshrc
rsync -avzhu --backup --suffix="$(date +'.%F_%H-%M')" zsh/functions/* "$HOME"/.my_zsh_functions

log_message "info" "Copying wallpapers to /usr/share/backgrounds..."
sudo mkdir -p /usr/share/backgrounds
sudo cp -ar wallpapers/* /usr/share/backgrounds/

log_message "info" "FC cache"
fc-cache -f

log_message "info" "Mouse configurations"
sudo cp ./etc/X11/xorg.conf.d/40-mouse.conf /etc/X11/xorg.conf.d/40-mouse.conf

log_message "info" "Setup oh my tmux"
if [ ! -d "$HOME/.tmux" ]; then
  git clone https://github.com/gpakosz/.tmux.git ~/.tmux
  ln -s "$HOME/.tmux/.tmux.conf" "$HOME/.config/tmux/tmux.conf"
  cp config/tmux/tmux.conf.local "$HOME/.config/tmux/tmux.conf.local"
else
  cp config/tmux/tmux.conf.local "$HOME/.config/tmux/tmux.conf.local"
fi
#cp "$HOME/.tmux/.tmux.conf.local" "$HOME/.config/tmux/tmux.conf.local"

# TFENV permissions
sudo usermod -aG tfenv dcr

log_message "info" "Setup apple magickeyboard conf"
sudo cp etc/modprobe.d/hid_apple.conf /etc/modprobe.d/hid_apple.conf
sudo chmod 644 /etc/modprobe.d/hid_apple.conf
# sudo modprobe -r hid_apple
# sudo modprobe hid_apple

log_message "info" "Setup vscode extensions"
file="misc/vscode-extensions.txt"
while IFS= read -r extension; do
    if [ ! -z "$extension" ]; then
        code --install-extension "$extension"
    fi
done < "$file"