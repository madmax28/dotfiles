#!/bin/bash

##
## Initialize git submodules
##

echo "========== Initializing git submodules =========="
git submodule update --init

##
## Vim stuff
##

read -p "Setup vim? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
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

        appendstring="let g:vimconfig_dir = \"$PWD\""
        if [ `grep "$appendstring" $HOME/.$FILE | wc -l` -eq 0 ]; then
            echo "appending \"$appendstring\" to $HOME/.$FILE"
            printf "\n$appendstring" >> $HOME/.$FILE
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

    # Let vundle install plugins
    echo "========== Installing plugins via Vundle ========"
    vim +PluginInstall +qall -c "q"
fi

##
## Bash stuff
##

read -p "Setup bash? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "========== Installing bash configuration ========="

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

read -p "Setup zsh? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "========== Installing zsh configuration ========="

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
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "========== Installing tmux configuration ========="

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
