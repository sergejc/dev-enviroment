#!/bin/bash

# SSH timeout
if ! grep -q "ServerAliveInterval 120" /etc/ssh/ssh_config; then
    echo "ServerAliveInterval 120" | sudo tee -a /etc/ssh/ssh_config
fi

sudo apt autoremove -y
