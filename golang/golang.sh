#!/bin/bash

while sudo fuser /var/lib/dpkg/lock >/dev/null 2>&1; do
    echo "apt process is running, wait for 5 seconds"
    sleep 5
done

# Apache
sudo apt install golang -y
sudo apt autoremove -y
