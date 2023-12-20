#! /usr/bin/env bash

extensions=(rust-lang.rust-analyzer mvllow.rose-pine naumovs.color-highlight \
            PKief.material-icon-theme golang.Go christian-kohler.path-intellisense \
            ionutvmi.path-autocomplete HashiCorp.terraform ms-python.python bungcip.better-toml AykutSarac.jsoncrack-vscode)

for extension in "${extensions[@]}"
do
  code --install-extension "$extension"
done