#!/bin/bash

# Locale
locale -a | grep -q en_GB.utf8 || sudo locale-gen en_GB.utf8

# Git
if ! hash git 2&> /dev/null; then
    sudo apt install git -y
fi
git config --local user.name "Sergej Charskij"
git config --local user.email "sergej.charskij@gmail.com"
git config --local core.editor vim
git config --local color.ui auto
git config --global core.filemode false

# ZSH
if ! hash zsh 2&> /dev/null; then
    sudo apt install zsh -y
fi

if ! hash pip 2&> /dev/null; then
    sudo apt install python-pip -y
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
    sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
    sudo sh -c 'echo "deb https://apt.dockerproject.org/repo ubuntu-$(lsb_release -sc) main" >> /etc/apt/sources.list.d/docker.list'
fi

if ! grep -q "docker.*$USER" /etc/group; then
    sudo groupadd docker
    sudo usermod -aG docker $USER
fi

# VirtualBox
ppa='virtualbox'
if ! grep -q "$ppa" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
    wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
    sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib" >> /etc/apt/sources.list.d/virtualbox.list'
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
    sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
fi

# Sublime 3
ppa='sublime-text-3'
if ! grep -q "$ppa" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
    sudo add-apt-repository ppa:webupd8team/sublime-text-3 -y
    mkdir -p $HOME/.config/sublime-text-3/Packages/User
    cat << EOF | tee -a $HOME/.config/sublime-text-3/Packages/User/Package\ Control.sublime-settings
{
    "installed_packages":
    [
        "AutoFileName",
        "Emmet",
        "LiveStyle",
        "Babel",
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
        "JSLint",
        "CSSComb",
        "Trimmer",
        "CSS3",
        "ColorHighlighter",
        "Git",
        "JsFormat",
        "Handlebars"
    ]
}
EOF

    cat << EOF | tee -a $HOME/.config/sublime-text-3/Packages/User/Preferences.sublime-settings
{
    "font_size": 11,
    "ignored_packages": [],
    "tab_size": 4,
    "translate_tabs_to_spaces": true,
    "vintage_ctrl_keys": true
}
EOF

fi

sudo apt-get update

sudo apt-get install google-chrome-stable -y
sudo apt-get install indicator-sysmonitor -y
sudo apt-get install keepassx -y
sudo apt-get install wine -y

sudo apt-get install linux-image-extra-$(uname -r) linux-image-extra-virtual
sudo apt-get install docker-engine -y
sudo service docker start

sudo apt-get install dkms virtualbox -y
sudo apt-get install oracle-java8-installer -y
sudo apt-get install sublime-text-installer -y
