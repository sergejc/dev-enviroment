#!/bin/bash

while sudo fuser /var/lib/dpkg/lock >/dev/null 2>&1; do
    echo "apt process is running, wait for 5 seconds"
    sleep 5
done

# Java
ppa='java'
if ! grep -q "$ppa" /etc/apt/sources.list /etc/apt/sources.list.d/* 2>/dev/null; then
    sudo apt-add-repository ppa:webupd8team/java -y
fi

sudo apt update
sudo apt install -y oracle-java8-installer
sudo apt autoremove -y
