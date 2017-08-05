#!/bin/bash

while sudo fuser /var/lib/dpkg/lock >/dev/null 2>&1; do
    echo "apt process is running, wait for 5 seconds"
    sleep 5
done

# Zsh
if ! hash zsh 2&> /dev/null; then
    sudo apt install zsh -y
fi

if ! grep -q "^$USER.*zsh" /etc/passwd; then
    sudo chsh -s $(which zsh) $USER
fi

# Powerline
if [ ! -d $HOME/.fonts ]; then
   mkdir $HOME/.fonts && git clone https://github.com/sergejc/ubuntu-mono-powerline-ttf.git $HOME/.fonts
   fc-cache -vf
fi

# OH MY ZSHELL
if [ ! -d $HOME/.oh-my-zsh ]; then
    git clone git://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh

    # OH MY ZSHELL PLUGINS
    ZSH_CUSTOM='.oh-my-zsh/custom'
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
fi

if [ ! -f $HOME/.zshrc ]; then
    cp $HOME/.oh-my-zsh/templates/zshrc.zsh-template $HOME/.zshrc
    sed -i -e 's/ZSH_THEME=".*"/ZSH_THEME="agnoster"/' $HOME/.zshrc
    sed -i 's/^plugins=(.*)/plugins=(git laravel vagrant docker Composer gem lein npm pip sudo tmux zsh-syntax-highlighting zsh-autosuggestions)/g' $HOME/.zshrc
fi

# Solarized Colorscheme
if [ ! -f "/usr/bin/gconftool-2" ]; then
    sudo apt install gconf2 -y
fi

if [ ! -d $HOME/solarize ]; then
    echo "create dark and light (lowercase) gnome terminal profile manualy, press Enter"
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

sudo apt autoremove -y
