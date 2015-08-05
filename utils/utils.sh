#!/bin/bash

# Locale
locale -a | grep -q en_GB.utf8 || sudo locale-gen en_GB.utf8

# Git 
if ! hash git 2&> /dev/null; then
    sudo apt-get install git -y 
fi
git config --local user.name "Sergej Charskij"
git config --local user.email "sergej.charskij@gmail.com" 
git config --local core.editor vim
git config --local color.ui auto
git config --global core.filemode false

# ZSH
if ! hash zsh 2&> /dev/null; then
    sudo apt-get install zsh -y
fi

if ! hash pip 2&> /dev/null; then
    sudo apt-get install python-pip -y
fi

# SysMonitor Indicator
ppa='fossfreedom'
if ! grep -q "$ppa" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
    sudo add-apt-repository ppa:fossfreedom/indicator-sysmonitor -y
fi

if ! grep -q "^$USER.*zsh" /etc/passwd; then
    chsh -s $(which zsh) $USER
fi

# Docker
ppa='docker'
if ! grep -q "$ppa" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
    sudo sh -c "echo deb https://get.docker.com/ubuntu docker main > /etc/apt/sources.list.d/docker.list"
fi

if ! grep -q "docker.*$USER" /etc/group; then
    sudo groupadd docker
    sudo gpasswd -a ${USER} docker
fi

# VirtualBox
ppa='virtualbox'
if ! grep -q "$ppa" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
    wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
    sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian trusty contrib" >> /etc/apt/sources.list.d/virtualbox.list'
fi

# Java
ppa='java'
if ! grep -q "$ppa" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
    sudo apt-add-repository ppa:webupd8team/java -y
fi

# Google Chrome
ppa='google'
if ! grep -q "$ppa" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
    wget -qO - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
fi

# Sublime 3
ppa='sublime-text-3'
if ! grep -q "$ppa" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
    sudo add-apt-repository ppa:webupd8team/sublime-text-3 -y
    wget -P $HOME/.config/sublime-text-3/Packages/User  https://sublime.wbond.net/Package%20Control.sublime-package
    cat << EOF | sudo tee -a $HOME/.config/sublime-text-3/Packages/User/Package Control.sublime-settings
{
    "installed_packages":
    [
        "AutoFileName",
        "Emmet",
        "SublimeLinter",
        "SideBarEnhancements",
        "BracketHighlighter",
        "SublimeCodeIntel",
        "Alignment",
        "SFTP",
        "DocBlockr",
        "AdvancedNewFile",
        "Pretty JSON",
        "HTMLBeautify",
        "FileDiffs",
        "Phpcs",
        "JSLint",
        "JSHint",
        "CSSComb",
        "Trimmer",
        "LiveStyle"
    ]
}
EOF
fi

# KeePassX 
ppa='keepassx'
if ! grep -q "$ppa" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
    sudo add-apt-repository ppa:keepassx/daily -y
fi

ppa='wine'
if ! grep -q "$ppa" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
    sudo add-apt-repository ppa:ubuntu-wine/ppa -y
fi


sudo apt-get update

sudo apt-get install google-chrome-stable -y
sudo apt-get install indicator-sysmonitor -y
sudo apt-get install keepassx -y
sudo apt-get install wine -y

sudo apt-get install lxc-docker -y

sudo apt-get install dkms virtualbox-4.3 -y
sudo apt-get install oracle-java8-installer -y
sudo apt-get install sublime-text-installer -y
