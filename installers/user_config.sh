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
".my_zsh_functions"
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
rsync -avzhu --backup --suffix="$(date +'.%F_%H-%M')" config/* "$HOME"/.config/

log_message "info" "Setup zsh shell as a default shell for user $USER"
sudo chsh -s "$(which zsh)" "$USER"

log_message "info" "Setup oh my zsh & plugins"
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
if [ ! -d "$HOME/.oh-my-zsh" ]; then sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended; fi
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions; fi
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting; fi

log_message "info" "Copying custom .zshrc and functions"
rsync -avzh zsh/.zshrc "$HOME"/.zshrc
rsync -avzhu zsh/functions/* "$HOME"/.my_zsh_functions

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

# Vscode extensions
# https://marketplace.visualstudio.com/vscode
# $ code --list-extensions

# log_message "info" "Setup vscode extensions"
# extensions=(rust-lang.rust-analyzer mvllow.rose-pine naumovs.color-highlight \
#             PKief.material-icon-theme golang.Go christian-kohler.path-intellisense \
#             ionutvmi.path-autocomplete HashiCorp.terraform ms-python.python bungcip.better-toml \
#             dracula-theme.theme-dracula \
#             Catppuccin.catppuccin-vsc-icons Catppuccin.catppuccin-vsc gitlab.gitlab-workflow)


# catppuccin.catppuccin-vsc-icons
# christian-kohler.path-intellisense
# dracula-theme.theme-dracula
# eamodio.gitlens
# hashicorp.hcl
# hashicorp.terraform
# ms-azuretools.vscode-docker
# ms-kubernetes-tools.vscode-kubernetes-tools
# ms-python.debugpy
# ms-python.python
# ms-python.vscode-pylance
# ms-vscode.makefile-tools
# oderwat.indent-rainbow
# pkief.material-icon-theme
# redhat.vscode-yaml
# vscode-icons-team.vscode-icons
# zeshuaro.vscode-python-poetry
#AykutSarac.jsoncrack-vscode 

# for extension in "${extensions[@]}"
# do
#   code --install-extension "$extension" --force
# done