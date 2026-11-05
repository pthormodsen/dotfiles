# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE

# Behaviour
setopt AUTO_CD INTERACTIVE_COMMENTS
bindkey -e

# Completion
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select

# PATH
typeset -U path
path=("$HOME/bin" "$HOME/.platformio/penv/bin" "$HOME/.local/bin" $path)

# Toolchains
[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env"

# >>> conda initialize >>>
if __conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"; then
    eval "$__conda_setup"
elif [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
    . "/opt/anaconda3/etc/profile.d/conda.sh"
fi
unset __conda_setup
# <<< conda initialize <<<

# Aliases
alias ll='ls -lAh'
alias ..='cd ..'
alias zj='zellij attach --create main'
alias tailscale='/Applications/Tailscale.app/Contents/MacOS/Tailscale'

alias gst='git status'
alias ga='git add'
alias gc='git commit'
alias gd='git diff'
alias gco='git checkout'
alias gl='git pull'
alias gp='git push'

# Prompt and plugins
eval "$(starship init zsh)"
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
