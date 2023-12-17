if status is-interactive
    # Commands to run in interactive sessions can go here
end

# My aliases
alias ls="lsd"
alias cat="bat"



# Init Starship
eval "$(starship init fish | source)"

# Setup Starship custom prompt
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml