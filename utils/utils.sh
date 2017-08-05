#!/bin/bash

while sudo fuser /var/lib/dpkg/lock >/dev/null 2>&1; do
    echo "apt process is running, wait for 5 seconds"
    sleep 5
done

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


if ! hash pip 2&> /dev/null; then
    sudo apt install python-pip -y
fi

# Docker
ppa='docker'
if ! grep -q "$ppa" /etc/apt/sources.list /etc/apt/sources.list.d/* 2>/dev/null; then
    curl -fsSL https://apt.dockerproject.org/gpg | sudo apt-key add -
    sudo add-apt-repository "deb https://apt.dockerproject.org/repo ubuntu-$(lsb_release -cs) stable"

    COMPOSE_VERSION=`git ls-remote https://github.com/docker/compose | grep refs/tags | grep -oP "[0-9]+\.[0-9][0-9]+\.[0-9]+$" | tail -n 1`
    sudo sh -c "curl -L https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose"
    sudo chmod +x /usr/local/bin/docker-compose
fi

if ! grep -q "docker.*$USER" /etc/group; then
    sudo groupadd docker
    sudo usermod -aG docker $USER
fi

# Google Chrome
ppa='google'
if ! grep -q "$ppa" /etc/apt/sources.list /etc/apt/sources.list.d/* 2>/dev/null; then
    wget -qO - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb stable main" >> /etc/apt/sources.list.d/google-chrome.list'
fi


# VirtualBox
ppa='virtualbox'
if ! grep -q "$ppa" /etc/apt/sources.list /etc/apt/sources.list.d/* 2>/dev/null; then
    wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
    sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib" >> /etc/apt/sources.list.d/virtualbox.list'
fi

# watchman
#git clone https://github.com/facebook/watchman.git /tmp/watchman
#(cd /tmp/watchman; ./autogen.sh && ./configure && make && sudo make install)

# Ansible
ppa='ansible'
if ! grep -q "$ppa" /etc/apt/sources.list /etc/apt/sources.list.d/* 2>/dev/null; then
    sudo apt install software-properties-common
    sudo apt-add-repository ppa:ansible/ansible
fi


# Sublime 3
ppa='sublime-text-3'
if ! grep -q "$ppa" /etc/apt/sources.list /etc/apt/sources.list.d/* 2>/dev/null; then
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
sudo apt install -y \
    google-chrome-stable \
    keepassx \
    wine-stable \
    docker-ce \
    dkms virtualbox \
    vagrant \
    ansible \
    sublime-text-installer

sudo service docker start
sudo apt autoremove -y
