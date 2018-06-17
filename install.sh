#!/bin/bash -e

##
## Functions
##

function append {
    echo "Appending to $1: $2"
    [ ! -f $1 ] && touch $1
    if [ `grep "$2" $1 | wc -l` -eq 0 ]; then
        printf "$2\n" >> $1
    fi
}

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
else
    if [ $(date -r $PWD/bin/spwd +%s) -lt $(date -r $PWD/spwd/spwd.c +%s) ]; then
        echo "Updating spwd"
        build_spwd
    fi
fi

##
## fzf
##

read -p "Install fzf? [y/N] " -n 1 -r; echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    FZF=$PWD/fzf

    [ -d $FZF ] && rm -rf $FZF
    git clone --depth 1 https://github.com/junegunn/fzf.git $FZF
    $FZF/install --bin

    ln -sf $FZF/bin/fzf $PWD/bin
    ln -sf $FZF/bin/fzf-tmux $PWD/bin
fi

##
## Vim stuff
##

read -p "Setup vim? [y/N] " -n 1 -r; echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Installing vim configuration"

    append $HOME/.vimrc "let g:vimconfig_dir = \"$PWD\""
    append $HOME/.vimrc "execute \"source \" . g:vimconfig_dir . \"/vimrc\""

    VUNDLE_URL=https://github.com/VundleVim/Vundle.vim.git
    VUNDLE_DIR=$PWD/vim/plugins/Vundle.vim
    if [ ! -d $VUNDLE_DIR ]; then
        echo "Cloning Vundle"
        git clone $VUNDLE_URL $VUNDLE_DIR
    fi

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

    append $HOME/.bashrc "export PATH=$PWD/bin:\$PATH"
    append $HOME/.bashrc "source $PWD/bashrc"
fi

##
## zsh Stuff
##

read -p "Setup zsh? [y/N] " -n 1 -r; echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Installing zsh configuration"

    append $HOME/.zshrc "export DOTFILES_DIR=$PWD"
    append $HOME/.zshrc "export PATH=\$DOTFILES_DIR/bin:\$PATH"
    append $HOME/.zshrc "source \$DOTFILES_DIR/zshrc"
fi

##
## tmux stuff
##

read -p "Setup tmux? [y/N] " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Installing tmux configuration"

    append $HOME/.tmux.conf "source-file $PWD/tmux.conf"
fi
