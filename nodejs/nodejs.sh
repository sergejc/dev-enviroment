#!/bin/bash

# NodeJs
filename='/etc/apt/sources.list.d/nodesource.list'
if [ ! -f $filename ]; then
    curl -sL https://deb.nodesource.com/setup_6.x -o nodesource_setup.sh
    sudo apt-get install nodejs -y
fi

# packages
sudo npm install -g supervisor node-inspector

# servers
sudo npm install -g webpack-dev-server express

# template engine
sudo npm install -g pug

# package management
sudo npm install -g bower requirejs jspm

# build tools
sudo npm install -g browserify gulp webpack rollup

# css processors
sudo npm install -g node-sass clean-css

# generators
sudo npm install -g yo create-react-app express-generator

# test tools
sudo npm install -g mocha eslint jasmine-node

# js transformer
sud npm install -g jscodeshift
