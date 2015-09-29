export EDITOR='vim'
export TERM='xterm-256color'

# Aliases
alias l='ls'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'

# Key bindings

export KEYTIMEOUT=0

MODE_INDICATOR="%{$fg_bold[red]%}<<<%{$reset_color%}"

function zle-keymap-select zle-line-init zle-line-finish {
    RPS1="${${KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/}"
    zle reset-prompt
    zle -R
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select

# Use vi mode cmd line editing
bindkey -v

# Allow forward-/backward-history-search
bindkey "^R"    history-incremental-search-backward
bindkey "^F"    history-incremental-search-forward
# Keep some emacs key bindings
bindkey "^A"    vi-beginning-of-line
bindkey "^E"    vi-end-of-line
bindkey "^?"    backward-delete-char
bindkey "^W"    backward-kill-word
bindkey "^[[3~" delete-char
# Vim conveniences
bindkey -M vicmd "H" vi-beginning-of-line
bindkey -M vicmd "L" vi-end-of-line
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M vicmd 'v' edit-command-line

# Fix home/end buttons
if [[ -n $terminfo[khome] ]]; then
    bindkey "$terminfo[khome]" vi-beginning-of-line
    bindkey -M vicmd "$terminfo[khome]" vi-beginning-of-line
fi
if [[ -n $terminfo[kend] ]]; then
    bindkey "$terminfo[kend]" vi-end-of-line
    bindkey -M vicmd "$terminfo[kend]" vi-end-of-line
fi
