if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Kubeconfigs
set -gx KUBECONFIG (string join ":" (find ~/.kube -name '*.yaml'))

# For Go binaries directly intalled using $ go install
set -gx PATH "$HOME/go/bin" $PATH;

# For Rust binaries directly installed using $ cargo install
set -gx PATH "$HOME/.cargo/bin" $PATH;

# ~/.local/bin for custom bin/scripts
set -gx PATH "$HOME/.local/bin" $PATH;

# SSH_AUTH_SOCK
# systemctl --user status ssh-agent.service
set SSH_AUTH_SOCK /run/user/1000/ssh-agent.socket

# My aliases
alias ls="lsd"
alias cat="bat"
alias kubectl="kubecolor"
alias purge="sudo pacman -Rns $(pacman -Qtdq) ; sudo fstrim -av"
alias update="paru -Syu --nocombinedupgrade"
alias maintenance="paru -Sc && sudo pacman -Scc"
alias gitscan="gitleaks detect --source . -v"
alias kns="kubens"
alias grep='grep --color=auto'
alias ls='lsd --group-directories-first'
alias tree='lsd --tree'
alias pbcopy='xclip -sel clip'
alias mycode='cd $HOME/Documents/Code'
alias work='cd $HOME/Documents/Code/Work'
alias personal='cd $HOME/Documents/Code/Personal'

# Setup Starship custom prompt
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml

# Init Starship
eval "$(starship init fish | source)"
