##
## ZSHRC
##

# Options
setopt autopushd pushdignoredups pushdminus pushdtohome
setopt chasedots cdablevars
setopt sharehistory

# Detect os
export UNAME=`uname`

# Aliases
alias l="ls"
alias ll="ls -lh"
alias la="ls -a"
alias lla="ls -lah"
alias ..="cd .."
alias l1="ls -1"

# Grep c files
cgrep () { grep "$@" `find . "(" -name "*c" -o -name "*h" ")" -a -type f | xargs`; }

# Prompt format: \n # USER at MACHINE in DIRECTORY on git:BRANCH STATE [TIME] \n $ 
function set_prompt {
    PROMPT="\
%{$terminfo[bold]$fg[blue]%}#%{$reset_color%} \
%{$fg[cyan]%}%n \
%{$fg[white]%}at \
%{$fg[green]%}$HOST \
%{$fg[white]%}in \
%{$fg[yellow]%}$dirname \
$gitinfo\
%{$fg[white]%}[%*]
%{$terminfo[bold]$fg[red]%}$ %{$reset_color%}"
}

# Directory info.
function chpwd {
    export DIR="`shortpwd`"
    local dirname="`echo $DIR`"
    set_prompt
}

# Update gitinfo
Gitinfo() {
    local bname=`git status 2>/dev/null | grep -om1 -E '\S*$'`
    if [ -z $bname ]; then
        GIT_INFO=''
        return
    fi
    GIT_INFO="%{$fg[white]%}on git:%{$fg[cyan]%}$bname"

    if [ `git status | grep -m1 behind | wc -l` -ne 0 ]; then
        GIT_INFO+="%{$fg[red]%} -"
        GIT_INFO+="`git status | grep -om1 -E '\d+'`%{$fg[white]%},"
    elif [ `git status | grep -m1 ahead | wc -l` -ne 0 ]; then
        GIT_INFO+="%{$fg[red]%} +"
        GIT_INFO+="`git status | grep -om1 -E '\d+'`%{$fg[white]%},"
    fi

    if [ `git status | grep -m1 clean | wc -l` -ne 0 ]; then
        GIT_INFO+="%{$fg[green]%} o "
    else
        GIT_INFO+="%{$fg[red]%} x "
    fi

    export GIT_INFO
}
local gitinfo="`echo $GIT_INFO`"

function precmd {
    Gitinfo
}

chpwd

# Use vim command line editing
export KEYTIMEOUT=0
# Ensures that $terminfo values are valid and updates editor information when
# the keymap changes.
function zle-keymap-select zle-line-init zle-line-finish {
  # The terminal must be in application mode when ZLE is active for $terminfo
  # values to be valid.
  if (( ${+terminfo[smkx]} )); then
    printf '%s' ${terminfo[smkx]}
  fi
  if (( ${+terminfo[rmkx]} )); then
    printf '%s' ${terminfo[rmkx]}
  fi

  zle reset-prompt
  zle -R
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select
zle -N edit-command-line

# Use vi mode cmd line editing
bindkey -v

# Allow forward-/backward-history-search
bindkey "^R" history-incremental-search-backward
bindkey "^F" history-incremental-search-forward
bindkey "^A" vi-beginning-of-line
bindkey "^E" vi-end-of-line
bindkey -M viins 'jk' vi-cmd-mode

# allow v to edit the command line (standard behaviour)
autoload -Uz edit-command-line
bindkey -M vicmd 'v' edit-command-line

# if mode indicator wasn't setup by theme, define default
if [[ "$MODE_INDICATOR" == "" ]]; then
  MODE_INDICATOR="%{$fg_bold[red]%}<%{$fg[red]%}<<%{$reset_color%}"
fi

function vi_mode_prompt_info() {
  echo "${${KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/}"
}

# define right prompt, if it wasn't defined by a theme
if [[ "$RPS1" == "" && "$RPROMPT" == "" ]]; then
  RPS1="$(vi_mode_prompt_info)"
fi
