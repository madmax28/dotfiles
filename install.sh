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

if [ ! -d $HOME/.vim ]; then
    echo "Copying $PWD/vim to $HOME/.vim"
    cp -R $PWD/vim $HOME/.vim
else
    read -p "Directory $HOME/.vim exists. Copy anyway? [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        cp -R $PWD/vim/* $HOME/.vim/
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
