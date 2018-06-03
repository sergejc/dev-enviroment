#!/bin/bash

while sudo fuser /var/lib/dpkg/lock >/dev/null 2>&1; do
    echo "apt process is running, wait for 5 seconds"
    sleep 5
done

# NodeJs
filename='/etc/apt/sources.list.d/nodesource.list'
if [ ! -f $filename ]; then
    curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
    sudo apt install nodejs -y
    sudo apt autoremove -y

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
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt-get update && sudo apt-get install yarn

    # package manager
    yarn global add pnpm

    # build tools
    yarn global add rollup jspm gulp-cli webpack parcel-bundler

    # packages
    yarn global add supervisor browser-sync

    # servers
    yarn global add node-static http-server webpack-dev-server live-server

    # tunnels
    yarn global add ngrok

    # generators
    yarn global add yo create-react-app express-generator create-next-app preact-cli

    # test tools
    yarn global add mocha karma jasmine-node

    # linters
    yarn global add eslint stylelint

    # elm
    yarn global add elm

    # clojurescript
    yarn global add shadow-cljs

    # monitor
    yarn global add nodemon

    # API documentation generator
    yarn global add jsdoc

    # css transfomer
    yarn global add postcss-cli

    # code checker
    yarn global add flow-bin

    # js optimizer
    yarn global add prepack

    # js formater
    yarn global add prettier

fi
