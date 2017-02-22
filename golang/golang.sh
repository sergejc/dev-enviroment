#!/bin/bash

while sudo fuser /var/lib/dpkg/lock >/dev/null 2>&1; do
    sleep 1
done

# Apache
sudo apt install golang -y
sudo apt autoremove -y
