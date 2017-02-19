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
    sudo yarn global add webpack-dev-server express node-static http-server live-server

    # tunnels
    sudo yarn global add localtunnel ngrok

    # build tools
    sudo yarn global add gulp webpack rollup jspm

    # generators
    sudo yarn global add yo create-react-app

    # test tools
    sudo yarn global add mocha jasmine-node karma-cli

    # linters
    sudo yarn global add -g eslint

    #elm
    sudo yarn global add -g elm
fi
