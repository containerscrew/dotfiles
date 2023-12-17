#! /usr/bin/env/bash
# ---------------P R O M P T------------------
# Init Starship
eval "$(starship init fish | source)"
# Setup Starship custom prompt
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
