#!/bin/bash

# Apache
sudo apt-get install apache2 -y
echo "ServerName localhost" | sudo tee /etc/apache2/conf-available/fqdn.conf && sudo a2enconf fqdn
sudo a2enmod rewrite
sudo a2enmod userdir
sudo service apache2 restart
