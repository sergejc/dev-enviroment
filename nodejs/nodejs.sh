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
    sudo apt install npm -y
    sudo apt autoremove -y

    sudo ln -s /usr/bin/nodejs /usr/bin/node

    # npm configure
    mkdir $HOME/.npm-global
    PATH=$HOME/.npm-global/bin:$PATH

    npm config set prefix $HOME/.npm-global
    npm config set init.author.name "Sergej Charskij"
    npm config set init.author.email "sergej.charskij@gmail.com"
    npm config set init.author.url "http://sergejc.com"
    npm config set init.license "MIT"
    npm config set init.version "0.0.1"
    npm config set loglevel="silent"

    # yarn
    curl -o- -L https://yarnpkg.com/install.sh | bash


    # package manager
    yarn global add pnpm

    # build tools
    yarn global add rollup jspm gulp-cli webpack

    # packages
    yarn global add supervisor browser-sync

    # servers
    yarn global add node-static http-server webpack-dev-server live-server

    # tunnels
    yarn global add ngrok

    # generators
    yarn global add yo create-react-app express-generator

    # test tools
    yarn global add mocha karma jasmine-node

    # linters
    yarn global add eslint

    #elm
    yarn global add elm

    # monitor
    yarn global add nodemon

    # API documentation generator
    yarn global add jsdoc

    # css transfomer
    yarn global add postcss-cli
fi
