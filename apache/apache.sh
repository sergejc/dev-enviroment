#!/bin/bash

while sudo fuser /var/lib/dpkg/lock >/dev/null 2>&1; do
    echo "apt process is running, wait for 5 seconds"
    sleep 5
done

# Apache
sudo apt install apache2 -y
echo "ServerName localhost" | sudo tee /etc/apache2/conf-available/fqdn.conf && sudo a2enconf fqdn
sudo a2enmod rewrite
sudo a2enmod userdir
sudo service apache2 restart

sudo apt autoremove -y
