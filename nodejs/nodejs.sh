#!/bin/bash

# NodeJs
filename='/etc/apt/sources.list.d/nodesource.list'
if [ ! -f $filename ]; then
    curl -sL https://deb.nodesource.com/setup_7.x | sudo bash -
    sudo apt install nodejs -y

    mkdir $HOME/.npm-global

    # package manager
    sudo npm install -g yarn

    # packages
    sudo npm install -g supervisor node-inspector browser-sync

    # servers
    sudo npm install -g webpack-dev-server express node-static http-server live-server

    # tunnels
    sudo npm install -g localtunnel ngrok

    # build tools
    sudo npm install -g gulp webpack rollup jspm

    # generators
    sudo npm install -g yo create-react-app

    # test tools
    sudo npm install -g mocha jasmine-node karma-cli

    # linters
    sudo npm install -g eslint
fi
