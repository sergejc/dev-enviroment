#!/bin/bash

# Dotfiles
filename=$HOME/dotfiles
if [ ! -d $filename ]; then
    git clone https://github.com/sergejc/dotfiles.git $HOME/dotfiles
    sed -i '1s/^/source ~\/dotfiles\/bash\/bashrc\n/' $HOME/.zshrc
fi

# Vim config
filename=$HOME/.vim/vimrc
if [ ! -f $filename ]; then
    git clone https://github.com/sergejc/vimconfig.git $HOME/.vim
    source $HOME/.vim/install.sh
fi
