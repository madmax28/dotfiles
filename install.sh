#!/bin/bash

##
## Functions
##

# Build spwd
function build_spwd {
[ -d bin ] || mkdir bin
make -C spwd && mv spwd/spwd bin
if [ $? -ne 0 ]; then
    echo "Error building spwd"
    exit 1
fi
}

if [ ! -f $PWD/bin/spwd ]; then
    echo "Building spwd"
    build_spwd
fi

##
## Vim stuff
##

read -p "Setup vim? [y/N] " -n 1 -r; echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Installing vim configuration"

    # Create vimrc
    if [ ! -f $HOME/.vimrc ]; then
        echo "Touching $HOME/.vimrc"
        touch $HOME/.vimrc
    fi

    # Add this to vimrc:
    #   " This stuff was added automatically
    #   let g:vimconfig_dir = "/Users/max/Workspace/vimconfig-git"
    #   execute "source " . g:vimconfig_dir . "/vimrc"
    appendString="\" This stuff was added automatically"
    if [ `grep "$appendString" $HOME/.vimrc | wc -l` -eq 0 ]; then
        echo "Appending \"$appendString\" to $HOME/.vimrc"
        printf "\n$appendString" >> $HOME/.vimrc
    fi
    appendstring="let g:vimconfig_dir = \"$PWD\""
    if [ `grep "$appendstring" $HOME/.vimrc | wc -l` -eq 0 ]; then
        echo "Appending \"$appendstring\" to $HOME/.vimrc"
        printf "\n$appendstring" >> $HOME/.vimrc
    fi
    sourceString="execute \"source \" . g:vimconfig_dir . \"/vimrc\""
    if [ `grep "$sourceString" $HOME/.vimrc | wc -l` -eq 0 ]; then
        echo "Appending \"$sourceString\" to $HOME/.vimrc"
        printf "\n$sourceString" >> $HOME/.vimrc
    fi

    # Clone Vundle if not present
    VUNDLE_URL=https://github.com/VundleVim/Vundle.vim.git
    VUNDLE_DIR=$PWD/vim/plugins/Vundle.vim
    if [ ! -d $VUNDLE_DIR ]; then
        echo "Cloning Vundle"
        git clone $VUNDLE_URL $VUNDLE_DIR
    fi

    # Let vundle install plugins
    echo "Installing plugins via Vundle"
    vim +PluginInstall +qall -c "q"
fi

read -p "Update previous plugins? [Y/n]" -n 1 -r -s; echo
if [[ ! $REPLY =~ ^[nN]$ ]]; then
    vim +PluginUpdate +qall -c "q"
fi

##
## Bash stuff
##

read -p "Setup bash? [y/N] " -n 1 -r; echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Installing bash configuration"

    if [ ! -f $HOME/.bashrc ]; then
        echo "Touching $HOME/.bashrc"
        touch $HOME/.bashrc
    fi

    STRING="source $PWD/bashrc"
    if [ `grep "$STRING" $HOME/.bashrc | wc -l` -eq 0 ]; then
        echo "Appending \"$STRING\" to $HOME/.bashrc"
        printf "\n# This line was added automatically" >> $HOME/.bashrc
        printf "\n$STRING" >> $HOME/.bashrc
    fi

    STRING="export PATH=$PWD/bin:\$PATH"
    if [ `grep "$STRING" $HOME/.bashrc | wc -l` -eq 0 ]; then
        echo "Appending \"$STRING\" to $HOME/.bashrc"
        printf "\n# This line was added automatically" >> $HOME/.bashrc
        printf "\n$STRING" >> $HOME/.bashrc
    fi
fi

##
## zsh Stuff
##

read -p "Setup zsh? [y/N] " -n 1 -r; echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Installing zsh configuration"

    if [ ! -f $HOME/.zshrc ]; then
        echo "Touching $HOME/.zshrc"
        touch $HOME/.zshrc
    fi

    # Has to be done _before_ source zshrc
    STRING="export PATH=$PWD/bin:\$PATH"
    if [ `grep "$STRING" $HOME/.zshrc | wc -l` -eq 0 ]; then
        echo "Appending \"$STRING\" to $HOME/.zshrc"
        printf "\n# This line was added automatically" >> $HOME/.zshrc
        printf "\n$STRING" >> $HOME/.zshrc
    fi

    STRING="source $PWD/zshrc"
    if [ `grep "$STRING" $HOME/.zshrc | wc -l` -eq 0 ]; then
        echo "Appending \"$STRING\" to $HOME/.zshrc"
        printf "\n# This line was added automatically" >> $HOME/.zshrc
        printf "\n$STRING" >> $HOME/.zshrc
    fi
fi


##
## tmux stuff
##

read -p "Setup tmux? [y/N] " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Installing tmux configuration"

    if [ ! -f $HOME/.tmux.conf ]; then
        echo "Touching $HOME/.tmux.conf"
        touch $HOME/.tmux.conf
    fi

    # Has to be done _before_ source zshrc
    STRING="source-file $PWD/tmux.conf"
    if [ `grep "$STRING" $HOME/.tmux.conf | wc -l` -eq 0 ]; then
        echo "Appending \"$STRING\" to $HOME/.tmux.conf"
        printf "\n# This line was added automatically" >> $HOME/.tmux.conf
        printf "\n$STRING" >> $HOME/.tmux.conf
    fi
fi
