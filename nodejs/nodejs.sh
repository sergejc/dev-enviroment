#!/bin/bash

# NodeJs
curl -sL https://deb.nodesource.com/setup | sudo bash -
sudo apt-get install nodejs -y

# NVM
curl https://raw.githubusercontent.com/creationix/nvm/v0.23.3/install.sh | bash 

echo 'export NVM_DIR="/home/vagrant/.nvm"' >> $HOME/.zshrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"' >> $HOME/.zshrc

source ~/.nvm/nvm.sh
nvm install 0.12.0 

# Packages
#npm install -g grunt-cli bower jade coffee-script express \
#    jasmine-node mocha yo browserify beefy gulp react-tools \
#    grunt-init http-server
