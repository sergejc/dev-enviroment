#!/bin/bash

sudo apt update && sudo apt install ugrade -y

# Locale
sudo locale-gen en_GB.utf8

sudo apt-get install \
    pv exuberant-ctags git tig htop aptitude \
    zsh vim mc xvfb unzip curl build-essential \
    software-properties-common xclip tree golang \
    iftop wget libssl-dev apt-transport-https \
    apache2-utils unity-tweak-tool dconf-cli \
    tmux nmap elinks openssl ca-certificates rlwrap \
    net-tools python-pip python-dev netcat sshfs \
    sshpass keychain whois silversearcher-ag -y

sudo apt autoremove -y
