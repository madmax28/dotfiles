#!/bin/bash

#
# Vim stuff
#

for FILE in vimrc gvimrc; do
    if [ ! -f $HOME/.$FILE ]; then
        echo "Touching $HOME/.$FILE"
        touch $HOME/.$FILE
    fi

    CMDSTR="so $PWD/$FILE"
    if [ `grep "$CMDSTR" $HOME/.$FILE | wc -l` -eq 0 ]; then
        echo "Appending \"$CMDSTR\" to $HOME/.$FILE"
        printf "\n\" This line was added automatically" >> $HOME/.$FILE
        printf "\n$CMDSTR" >> $HOME/.$FILE
    fi
done

# Install plugins
if [ ! -d $HOME/.vim ]; then
    echo "Copying $PWD/vim to $HOME/.vim"
    cp -R $PWD/vim $HOME/.vim
else
    read -p "Directory $HOME/.vim exists. Replace? [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        read -p "Backup $HOME/.vim? [Y/n] " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[nN]$ ]]; then
            echo "Backing up $HOME/.vim to $HOME/.vim.bak"
            [ -d $HOME/.vim.bak ] && rm -rf $HOME/.vim.bak
            cp $HOME/.vim $HOME/.vim.bak
        fi
        rm -rf $HOME/.vim
        cp -R $PWD/vim $HOME/.vim
    fi
fi

#
# Bash stuff
#

if [ ! -f $HOME/.bashrc ]; then
    echo "Touching $HOME/.bashrc"
    touch $HOME/.bashrc
fi

CMDSTR="source $PWD/bashrc"
if [ `grep "$CMDSTR" $HOME/.bashrc | wc -l` -eq 0 ]; then
    echo "Appending \"$CMDSTR\" to $HOME/.bashrc"
    printf "\n# This line was added automatically" >> $HOME/.bashrc
    printf "\n$CMDSTR" >> $HOME/.bashrc
fi
