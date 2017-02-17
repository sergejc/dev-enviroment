#!/bin/bash

if [ ! -d $HOME/.tmux-powerline ]; then
    git clone https://github.com/sergejc/tmux-powerline.git $HOME/.tmux-powerline
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    $HOME/dev-enviroment/tmux/tmux.conf > $HOME/.tmux.conf
fi

sudo apt autoremove -y
