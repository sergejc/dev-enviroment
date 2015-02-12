#!/bin/bash

# OH MY ZSHELL
if [ ! -d $HOME/.oh-my-zsh ]; then
    git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
fi

if [ ! -f $HOME/.zshrc ]; then
    cp $HOME/.oh-my-zsh/templates/zshrc.zsh-template $HOME/.zshrc
    sed -i -e 's/ZSH_THEME=".*"/ZSH_THEME="agnoster"/' $HOME/.zshrc
    sed -i 's/^plugins=(.*)/plugins=(git laravel vagrant foo)/g' $HOME/.zshrc
fi

# Solarized Colorscheme
if [ ! -f "/usr/bin/gconftool-2" ]; then
    sudo apt-get install gconf2 -y
fi
echo "create dark and light gnome terminal profile manualy"
read tmp

git clone https://github.com/sergejc/gnome-terminal-colors-solarized solarized
chmod +x solarized/install.sh && solarized/install.sh && solarized/install.sh

# Dircolors
if [ ! -d $HOME/.foldercolors ]; then
    git clone https://github.com/sergejc/dircolors-solarized $HOME/.foldercolors 
fi

# MC solarized
if [ ! -d $HOME/.mc ]; then
    git clone https://github.com/sergejc/mc $HOME/.mc
fi

# SSH timeout
if ! grep -q "ServerAliveInterval 120" /etc/ssh/ssh_config; then
    echo "ServerAliveInterval 120" | sudo tee -a /etc/ssh/ssh_config
fi
