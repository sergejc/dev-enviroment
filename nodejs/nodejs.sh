#!/bin/bash

while sudo fuser /var/lib/dpkg/lock >/dev/null 2>&1; do
    sleep 1
done

# NodeJs
filename='/etc/apt/sources.list.d/nodesource.list'
if [ ! -f $filename ]; then
    curl -sL https://deb.nodesource.com/setup_7.x | sudo bash -
    sudo apt install nodejs -y
    sudo apt autoremove -y

    mkdir $HOME/.npm-global
    echo "prefix=$HOME/.npm-global" > $HOME/.npmrc

    # package manager
    npm install -g yarn

    # packages
    sudo yarn global add supervisor browser-sync

    # servers
    sudo yarn global add node-static http-server
    npm install -g webpack-dev-server live-server

    # tunnels
    sudo yarn global add ngrok

    # build tools
    sudo yarn global add rollup
    npm install -g gulp jspm webpack

    # generators
    sudo yarn global add yo create-react-app

    # test tools
    sudo yarn global add mocha jasmine-node

    # linters
    npm install -g eslint

    #elm
    npm install -g elm
fi
