#!/bin/bash

# SysMonitor Indicator
sudo add-apt-repository ppa:fossfreedom/indicator-sysmonitor
sudo apt-get update && sudo apt-get install indicator-sysmonitor -y
sudo apt-get install indicator-sysmonitor -y


# OH MY ZSHELL
curl -L http://install.ohmyz.sh | sh
chsh -s $(which zsh)

# Solorize
echo "create dark and light gnome terminal profile manualy"
read tmp

git clone https://github.com/Anthony25/gnome-terminal-colors-solarized.git solarized
chmod +x solarized/install.sh && solarized/install.sh && solarized/install.sh

# Docker
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
sudo sh -c "echo deb https://get.docker.com/ubuntu docker main > /etc/apt/sources.list.d/docker.list"
sudo apt-get update
sudo apt-get install lxc-docker -y
sudo groupadd docker
sudo gpasswd -a ${USER} docker
sudo service docker restart

# VirtualBox
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian trusty contrib" >> /etc/apt/sources.list.d/virtualbox.list'
sudo apt-get update
sudo apt-get install dkms virtualbox-4.3 -y

# Java
sudo apt-add-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer -y

# Google Chrome
wget -qO - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt-get update
sudo apt-get install google-chrome-stable -y
