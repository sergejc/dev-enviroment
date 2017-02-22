#!/bin/bash

while sudo fuser /var/lib/dpkg/lock >/dev/null 2>&1; do
    sleep 1
done

# MySQL
sudo apt install mysql-server -y
sudo apt autoremove -y
