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

if ! grep -q "^$USER.*zsh" /etc/passwd; then
    chsh -s $(which zsh) $USER
fi

# Docker
ppa='docker'
if ! grep -q "$ppa" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
    curl -fsSL https://apt.dockerproject.org/gpg | sudo apt-key add -
    sudo add-apt-repository "deb https://apt.dockerproject.org/repo ubuntu-$(lsb_release -cs) main"
fi

if ! grep -q "docker.*$USER" /etc/group; then
    sudo groupadd docker
    sudo usermod -aG docker $USER
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
    sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
fi


# VirtualBox
ppa='virtualbox'
if ! grep -q "$ppa" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
    wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
    sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib" >> /etc/apt/sources.list.d/virtualbox.list'
fi

# Sublime 3
ppa='sublime-text-3'
if ! grep -q "$ppa" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
    sudo add-apt-repository ppa:webupd8team/sublime-text-3
    mkdir -p $HOME/.config/sublime-text-3/Packages/User
    cat << EOF | tee -a $HOME/.config/sublime-text-3/Packages/User/Package\ Control.sublime-settings
{
        "bootstrapped": true,
        "in_process_packages": [],
        "installed_packages":
        [
        "AdvancedNewFile",
        "Alignment",
        "AutoFileName",
        "Babel",
        "BracketHighlighter",
        "CSS3",
        "DocBlockr",
        "Emmet",
        "FileDiffs",
        "Git",
        "Handlebars",
        "HTMLBeautify",
        "JsFormat",
        "JSLint",
        "LiveStyle",
        "Package Reloader",
        "Pretty JSON",
        "SFTP",
        "SideBarEnhancements",
        "SublimeCodeIntel",
        "SublimeLinter",
        "Trimmer"
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

sudo apt update

sudo apt install google-chrome-stable -y
sudo apt install keepassx -y
sudo apt install wine-stable -y

sudo apt install linux-image-extra-$(uname -r) linux-image-extra-virtual
sudo apt install docker-engine -y
sudo service docker start

sudo apt install dkms virtualbox -y
sudo apt install vagrant
sudo apt install oracle-java8-installer -y
sudo apt install sublime-text-installer -y
