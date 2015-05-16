#!/bin/bash

# Vim config
filename=$HOME/.vim/vimrc
if [ ! -f $filename ]; then
    git clone https://github.com/sergejc/vimconfig.git $HOME/.vim
    source $HOME/.vim/install.sh
fi
