#!/bin/bash

# FZF
if [ ! -d $HOME/.fzf ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    $HOME/.fzf/install
    source $HOME/.zshrc
fi
