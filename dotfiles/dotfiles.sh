#!/bin/bash

# Dotfiles
filename=$HOME/dotfiles
if [ ! -d $filename ]; then
    git clone https://github.com/sergejc/dotfiles.git $HOME/dotfiles
    sed -i '1s/^/source ~\/dotfiles\/bash\/bashrc\n/' $HOME/.zshrc
    echo 'source dotfiles/bash/bashrc' >> $HOME/.zshrc
fi

