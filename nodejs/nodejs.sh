#!/bin/bash

# NodeJs
filename='/etc/apt/sources.list.d/nodesource.list'
if [ ! -f $filename ]; then
    curl -sL https://deb.nodesource.com/setup_7.x | sudo bash -
    sudo apt install nodejs -y
    sudo apt autoremove -y

    mkdir $HOME/.npm-global

    # package manager
    sudo npm install -g yarn

    # packages
    sudo yarn global add supervisor browser-sync

    # servers
    sudo yarn global add node-static http-server
    sudo npm install -g webpack-dev-server live-server

    # tunnels
    sudo yarn global add ngrok

    # build tools
    sudo yarn global add rollup
    sudo npm install -g gulp jspm webpack

    # generators
    sudo yarn global add yo create-react-app

    # test tools
    sudo yarn global add mocha jasmine-node

    # linters
    sudo npm install -g eslint

    #elm
    sudo npm install -g elm
fi
