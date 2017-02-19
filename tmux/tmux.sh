#!/bin/bash

if [ ! -d $HOME/.tmux-powerline ]; then
    sudo apt install tmux -y
    git clone https://github.com/sergejc/tmux-powerline.git $HOME/.tmux-powerline
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    cp $HOME/dev-enviroment/tmux/tmux.conf $HOME/.tmux.conf
fi

sudo apt autoremove -y
