export EDITOR='vim'
export TERM='xterm-256color'

# Aliases
alias l='ls'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'

# Job control
alias j='jobs'

alias f='fg'
alias f1='fg %1'
alias f2='fg %2'
alias f3='fg %3'
alias f4='fg %4'
alias f5='fg %5'

alias b='bg'
alias b1='bg %1'
alias b2='bg %2'
alias b3='bg %3'
alias b4='bg %4'
alias b5='bg %5'

alias k1='kill %1'
alias k2='kill %2'
alias k3='kill %3'
alias k4='kill %4'
alias k5='kill %5'

alias gd='git difftool'

# No blue directories for ls

export LS_COLORS=$LS_COLORS:'di=0;35:'

# Key bindings

export KEYTIMEOUT=0

MODE_INDICATOR="%{$fg_bold[red]%}<<<%{$reset_color%}"

function vimode {
    mode="${${KEYMAP/vicmd/N}/(main|viins)/$}"
    if [ -z $mode ]; then
        echo "$"
    else
        echo $mode
    fi
}

local dirname='$(spwd)'
local vi_indic='$(vimode)'
#local vimode='${${KEYMAP/vicmd/N}/(main|viins)/$}'

PROMPT="
%{$fg_bold[blue]%}#%{$reset_color%} \
%{$fg[cyan]%}%n%{$reset_color%} \
at \
%{$fg[green]%}%M%{$reset_color%} \
in \
%{$fg_bold[yellow]%}${dirname}%{$reset_color%} \
[%*%(1j., %j job.)%(2j.s.)]
%{$fg_bold[red]%}${vi_indic}%{$reset_color%} "

function zle-keymap-select zle-line-init zle-line-finish {
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
