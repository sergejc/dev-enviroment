#!/bin/bash

sudo apt-get update && sudo apt-get install ugrade -y

# Locale
sudo locale-gen en_GB.utf8

sudo apt-get install \
    pv exuberant-ctags git htop aptitude \
    zsh vim mc xvfb unzip curl build-essential \
    software-properties-common xclip tree \
    wget memcached apache2-utils libssl-dev \
    apt-transport-https iftop unity-tweak-tool dconf-cli \
    tmux nmap elinks openssl ca-certificates rlwrap \
    net-tools python-pip netcat -y 
