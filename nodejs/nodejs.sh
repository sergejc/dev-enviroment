#!/bin/bash

# NodeJs
filename='/etc/apt/sources.list.d/nodesource.list'
if [ ! -f $filename ]; then
    curl -sL https://deb.nodesource.com/setup | sudo bash -
    sudo apt-get install nodejs -y
fi

# NVM
if [ ! -f $HOME/.nvm/nvm.sh ]; then
    curl https://raw.githubusercontent.com/creationix/nvm/v0.23.3/install.sh | bash 

    source ~/.nvm/nvm.sh
    nvm install 0.12.0 

    # Packages
    npm install -g grunt-cli bower jade coffee-script express express-generator jasmine-node mocha yo browserify beefy gulp react-tools grunt-init http-server jshint stylus node-sass less autoprefixer clean-css mean-cli requirejs supervisor node-inspector

    echo "source $HOME/.nvm/nvm.sh" >> $HOME/.zshrc
    echo "nvm use 0.12 >> /dev/null" >> $HOME/.zshrc
    
fi

