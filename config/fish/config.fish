if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Kubeconfigs
# THIS NOT WORKS WITH KUBECTX
# set -gx KUBECONFIG (string join ":" (find ~/.kube -name '*.yaml'))

# SSH AGENT
#fish_ssh_agent

# My aliases
alias ls="lsd"
alias cat="bat --style=plain --theme='Solarized (dark)'"
alias kubectl="kubecolor"
alias purge="sudo pacman -Rns $(pacman -Qtdq) ; sudo fstrim -av"
alias paru-update="paru -Syu --nocombinedupgrade"
alias maintenance="paru -Sc && sudo pacman -Scc"
alias git-scan="gitleaks detect --source . -v"
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

# Tmux config
#if tmux has-session -t "workspace" >/dev/null 2>&1
#    # If the session already exists, attach to it
#    tmux attach-session -t "workspace"
#else
#    # If it doesn't exist, create a new session named "workspace"
#    tmux new -s "workspace"
#end
