#!/bin/bash

# Powerline
if [ ! -d $HOME/.fonts ]; then
   mkdir $HOME/.fonts && git clone https://github.com/sergejc/ubuntu-mono-powerline-ttf.git $HOME/.fonts
   fc-cache -vf
fi

# OH MY ZSHELL
if [ ! -d $HOME/.oh-my-zsh ]; then
    git clone git://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
fi

if [ ! -f $HOME/.zshrc ]; then
    cp $HOME/.oh-my-zsh/templates/zshrc.zsh-template $HOME/.zshrc
    sed -i -e 's/ZSH_THEME=".*"/ZSH_THEME="agnoster"/' $HOME/.zshrc
    sed -i 's/^plugins=(.*)/plugins=(git laravel vagrant foo)/g' $HOME/.zshrc
fi

# Solarized Colorscheme
if [ ! -f "/usr/bin/gconftool-2" ]; then
    sudo apt install gconf2 -y
fi


if [ ! -d $HOME/solarize ]; then
    echo "create Dark and Light gnome terminal profile manualy, press Enter"
    read tmp
    git clone https://github.com/sergejc/gnome-terminal-colors-solarized $HOME/solarized
    chmod +x $HOME/solarized/install.sh && $HOME/solarized/install.sh && $HOME/solarized/install.sh
    rm -rf $HOME/solarized
fi

# Dircolors
if [ ! -d $HOME/.foldercolors ]; then
    git clone https://github.com/sergejc/dircolors-solarized $HOME/.foldercolors
fi

# MC solarized
if [ ! -d $HOME/.mc ]; then
    git clone https://github.com/sergejc/mc $HOME/.mc
fi

# FZF
if [ ! -d $HOME/.fzf ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi
