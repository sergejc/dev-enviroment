#!/bin/bash

# NodeJs
filename='/etc/apt/sources.list.d/nodesource.list'
if [ ! -f $filename ]; then
    curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
    sudo apt-get install nodejs -y
fi

# NVM
if [ ! -f $HOME/.nvm/nvm.sh ]; then
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.30.1/install.sh | bash

    source ~/.nvm/nvm.sh
    nvm install 5.3.0

    # Packages
    npm install -g bower jade express supervisor babel express-generator react-tools http-server mean-cli node-inspector

    # build tools
    npm install -g yo browserify gulp requirejs jspm webpack grunt-init grunt-cli

    # css processors
    npm install -g stylus less node-sass clean-css

    # test tools
    npm install -g mocha eslint jasmine-node


    echo "source $HOME/.nvm/nvm.sh" >> $HOME/.zshrc
    echo "nvm use 5.3.0 >> /dev/null" >> $HOME/.zshrc

fi

