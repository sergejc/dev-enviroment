#!/bin/bash

# Dotfiles
filename=$HOME/dotfiles
if [ ! -d $filename ]; then
    git clone https://github.com/sergejc/dotfiles.git $HOME/dotfiles
    echo "source $HOME/dotfiles/bash/main.sh" >> $HOME/.zshrc
fi

