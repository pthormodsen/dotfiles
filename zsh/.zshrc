# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE

# Behaviour
setopt AUTO_CD CORRECT INTERACTIVE_COMMENTS
bindkey -e
# Word navigation with Option+Left/Right (Ghostty sends these as plain alt+arrows)
bindkey '^[[1;3D' backward-word
bindkey '^[[1;3C' forward-word

# Up/Down search history by what's already typed
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[OA' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey '^[OB' down-line-or-beginning-search

# Completion (full security check only when the dump is over a day old)
autoload -Uz compinit
_zcompdump_stale=(~/.zcompdump(N.mh+24))
if (( $#_zcompdump_stale )) || [[ ! -e ~/.zcompdump ]]; then
    compinit
else
    compinit -C
fi
unset _zcompdump_stale
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:*' fzf-flags --ignore-case
zstyle ':fzf-tab:complete:*' fzf-preview '
    if [[ -d $realpath ]]; then
        eza -1 --color=always --group-directories-first -- $realpath
    elif [[ -f $realpath ]]; then
        bat --color=always --theme="Catppuccin Mocha" --style=plain --paging=never --line-range=:200 -- $realpath
    fi'
source /opt/homebrew/opt/fzf-tab/share/fzf-tab/fzf-tab.zsh

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
alias ls='eza --group-directories-first'
alias ll='eza -l --group-directories-first --no-permissions --no-user'
alias la='eza -la --group-directories-first --no-permissions --no-user'
alias cat='bat --theme="Catppuccin Mocha" --style=plain --paging=never'
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
eval "$(atuin init zsh --disable-up-arrow --disable-ctrl-r --disable-ai)"

# Suggest the latest command run in this folder that starts with what's typed.
# Set after atuin's init, which adds its own strategy.
_zsh_autosuggest_strategy_atuin_directory() {
    suggestion=$(ATUIN_QUERY="$1" atuin search --cmd-only --author '$all-user' --limit 1 \
        --filter-mode directory --search-mode prefix 2>/dev/null)
}
ZSH_AUTOSUGGEST_STRATEGY=(atuin_directory match_prev_cmd completion)
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
