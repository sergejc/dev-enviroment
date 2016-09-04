#!/bin/bash

# NodeJs
filename='/etc/apt/sources.list.d/nodesource.list'
if [ ! -f $filename ]; then
    curl -sL https://deb.nodesource.com/setup_6.x | sudo bash -
    sudo apt-get install nodejs -y

    # packages
    sudo npm install -g supervisor node-inspector

    # servers
    sudo npm install -g webpack-dev-server express

    # package management
    sudo npm install -g bower requirejs jspm

    # build tools
    sudo npm install -g browserify gulp webpack rollup

    # generators
    sudo npm install -g yo create-react-app express-generator

    # test tools
    sudo npm install -g mocha eslint jasmine-node karma-cli
fi

