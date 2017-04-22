#!/bin/bash

while sudo fuser /var/lib/dpkg/lock >/dev/null 2>&1; do
    echo "apt process is running, wait for 5 seconds"
    sleep 5
done

# NodeJs
filename='/etc/apt/sources.list.d/nodesource.list'
if [ ! -f $filename ]; then
    curl -sL https://deb.nodesource.com/setup_7.x | sudo bash -
    sudo apt install nodejs -y
    sudo apt autoremove -y

    # npm configure
    mkdir $HOME/.npm-global

    npm config set prefix $HOME/.global-modules
    npm config set init.author.name "Sergej Charskij"
    npm config set init.author.email "sergej.charskij@gmail.com"
    npm config set init.author.url "http://sergejc.com"
    npm config set init.license "MIT"
    npm config set init.version "0.0.1"
    npm config set loglevel="silent"

    # package manager
    npm install -g yarn

    # packages
    yarn global add supervisor browser-sync

    # servers
    yarn global add node-static http-server
    npm install -g webpack-dev-server live-server

    # tunnels
    yarn global add ngrok

    # build tools
    yarn global add rollup
    npm install -g gulp jspm webpack

    # generators
    yarn global add yo create-react-app express-generator

    # test tools
    yarn global add mocha jasmine-node

    # linters
    npm install -g eslint

    #elm
    npm install -g elm

    # monitor
    npm install -g nodemon
fi
