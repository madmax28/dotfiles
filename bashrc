#
# /etc/bash.bashrc
#

# Get os uname
os_uname=`uname`

#####################
# Color definitions #
#####################

# Normal Colors
Black="\[\e[0;30m\]"        # Black
Red="\[\e[0;31m\]"          # Red
Green="\[\e[0;32m\]"        # Green
Yellow="\[\e[0;33m\]"       # Yellow
Blue="\[\e[0;34m\]"         # Blue
Purple="\[\e[0;35m\]"       # Purple
Cyan="\[\e[0;36m\]"         # Cyan
White="\[\e[0;37m\]"        # White

# Bold
BBlack="\[\e[1;30m\]"       # Black
BRed="\[\e[1;31m\]"         # Red
BGreen="\[\e[1;32m\]"       # Green
BYellow="\[\e[1;33m\]"      # Yellow
BBlue="\[\e[1;34m\]"        # Blue
BPurple="\[\e[1;35m\]"      # Purple
BCyan="\[\e[1;36m\]"        # Cyan
BWhite="\[\e[1;37m\]"       # White

# Background
On_Black="\[\e[40m\]"       # Black
On_Red="\[\e[41m\]"         # Red
On_Green="\[\e[42m\]"       # Green
On_Yellow="\[\e[43m\]"      # Yellow
On_Blue="\[\e[44m\]"        # Blue
On_Purple="\[\e[45m\]"      # Purple
On_Cyan="\[\e[46m\]"        # Cyan
On_White="\[\e[47m\]"       # White

NC="\[\e[m\]"               # Color Reset

###########
# Aliases #
###########

# colors, laziness, ..
alias grep="grep --color=auto -n"
if [ $os_uname == "Darwin" ]; then
    alias ls="ls -G -h"
elif [ $os_uname == "Linux" ]; then
    alias ls="ls --color=auto -h"
fi
alias l="ls -h"
alias la="ls -ah"
alias lla="ls -lah"
alias ll="ls -lh"
alias ..="cd .."

# make meld work on OS X
if [ $os_uname == "Darwin" ]; then
    alias meld="LANG=C LC_ALL=C meld"
fi

# ls colors
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# PS1
export PS1="${NC}\u${Green}@${NC}\h${Green}:${NC}\W${Green} $ ${NC}"

# My scripts
export PATH="${PATH}:/Users/max/Scripts"

# Macports stuff
export PATH="/opt/local/bin:/opt/local/sbin:${PATH}"

# Add wine-git to path
export PATH="${PATH}:/Users/max/Workspace/wine-git/install-dir/bin"
export DYLD_FALLBACK_LIBRARY_PATH="/usr/X11/lib:/usr/lib:/opt/local/lib"
