if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Kubeconfigs
set -gx KUBECONFIG (string join ":" (find ~/.kube -name '*.yaml'))

# For Go binaries directly intalled using $ go install
set -gx PATH "$HOME/go/bin" $PATH;

# For Rust binaries directly installed using $ cargo install
set -gx PATH "$HOME/.cargo/bin" $PATH;

# My aliases
alias ls="lsd"
alias cat="bat --style=plain --theme='Solarized (dark)'"
alias kubectl="kubecolor"



# Init Starship
eval "$(starship init fish | source)"

# Setup Starship custom prompt
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml