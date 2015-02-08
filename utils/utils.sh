#!/bin/bash

# Locale
locale -a | grep -q en_GB.utf8 || sudo locale-gen en_GB.utf8

# Git 
if ! hash git 2&> /dev/null; then
    sudo apt-get install git -y 
fi

# ZSH
if ! hash zsh 2&> /dev/null; then
    sudo apt-get install zsh -y
fi

if ! hash pip 2&> /dev/null; then
    sudo apt-get install python-pip -y
fi

# SysMonitor Indicator
filename='/etc/apt/sources.list.d/fossfreedom-ubuntu-indicator-sysmonitor-utopic.list'
if [ ! -f $filename ]; then
    sudo add-apt-repository ppa:fossfreedom/indicator-sysmonitor -y
fi

# OH MY ZSHELL
if [ ! -d $HOME/.oh-my-zsh ]; then
    git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
fi

if ! grep -q "^$USER.*zsh" /etc/passwd; then
    chsh -s $(which zsh) $USER
fi

if [ ! -f $HOME/.zshrc ]; then
    cp $HOME/.oh-my-zsh/templates/zshrc.zsh-template $HOME/.zshrc
    sed -i -e 's/ZSH_THEME=".*"/ZSH_THEME="agnoster"/' $HOME/.zshrc
fi

# Solarized Colorscheme
if [ ! -f "/usr/bin/gconftool-2" ]; then
    sudo apt-get install gconf2 -y
fi
echo "create dark and light gnome terminal profile manualy"
read tmp

git clone https://github.com/Anthony25/gnome-terminal-colors-solarized.git solarized
chmod +x solarized/install.sh && solarized/install.sh && solarized/install.sh

# Docker
filename='/etc/apt/sources.list.d/docker.list'
if [ ! -f $filename ]; then
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
    sudo sh -c "echo deb https://get.docker.com/ubuntu docker main > /etc/apt/sources.list.d/docker.list"
fi

if ! grep -q "docker.*$USER" /etc/group; then
    sudo groupadd docker
    sudo gpasswd -a ${USER} docker
fi

# VirtualBox
filename='/etc/apt/sources.list.d/virtualbox.list'
if [ ! -f $filename ]; then
    wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
    sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian trusty contrib" >> /etc/apt/sources.list.d/virtualbox.list'
fi

# Java
filename='/etc/apt/sources.list.d/webupd8team-ubuntu-java-utopic.list'
if [ ! -f $filename ]; then
    sudo apt-add-repository ppa:webupd8team/java -y
fi

# Google Chrome
filename='/etc/apt/sources.list.d/google-chrome.list'
if [ ! -f $filename ]; then
    wget -qO - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
fi

# Sublime 3
filename='/etc/apt/sources.list.d/webupd8team-ubuntu-sublime-text-3-utopic.list'
if [ ! -f $filename ]; then
    sudo add-apt-repository ppa:webupd8team/sublime-text-3 -y
fi

sudo apt-get update

sudo apt-get install google-chrome-stable -y
sudo apt-get install indicator-sysmonitor -y

sudo apt-get install lxc-docker -y
sudo service docker restart

sudo apt-get install dkms virtualbox-4.3 -y
sudo apt-get install oracle-java8-installer -y
sudo apt-get install sublime-text-installer -y
