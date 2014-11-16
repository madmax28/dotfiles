#!/bin/bash

##
## Initialize git submodules
##

echo "========== Initializing git submodules =========="
git submodule update --init

##
## Vim stuff
##

echo "========== Installing vim configuration ========="
for FILE in vimrc; do
    if [ ! -f $HOME/.$FILE ]; then
        echo "Touching $HOME/.$FILE"
        touch $HOME/.$FILE
    fi

    appendString="\" This stuff was added automatically"
    if [ `grep "$appendString" $HOME/.$FILE | wc -l` -eq 0 ]; then
        echo "Appending \"$appendString\" to $HOME/.$FILE"
        printf "\n$appendString" >> $HOME/.$FILE
    fi

    appendString="let g:myvimrc = \"$PWD/vimrc\""
    if [ `grep "$appendString" $HOME/.$FILE | wc -l` -eq 0 ]; then
        echo "Appending \"$appendString\" to $HOME/.$FILE"
        printf "\n$appendString" >> $HOME/.$FILE
    fi

    sourceString="so $PWD/$FILE"
    if [ `grep "$sourceString" $HOME/.$FILE | wc -l` -eq 0 ]; then
        echo "Appending \"$sourceString\" to $HOME/.$FILE"
        printf "\n$sourceString" >> $HOME/.$FILE
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

echo "========== Installing plugins via Vundle ========"
# Let vundle install plugins
vim +PluginInstall +qall -c "q"
# Apply some patches
patch $HOME/.vim/plugins/snipMate/snippets/c.snippets ./c.snippets.patch

##
## Bash stuff
##

if [ ! -f $HOME/.bashrc ]; then
    echo "Touching $HOME/.bashrc"
    touch $HOME/.bashrc
fi

sourceString="source $PWD/bashrc"
if [ `grep "$sourceString" $HOME/.bashrc | wc -l` -eq 0 ]; then
    echo "Appending \"$sourceString\" to $HOME/.bashrc"
    printf "\n# This line was added automatically" >> $HOME/.bashrc
    printf "\n$sourceString" >> $HOME/.bashrc
fi
