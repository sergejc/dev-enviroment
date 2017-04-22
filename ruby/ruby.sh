#!/bin/bash

git clone https://github.com/rbenv/rbenv.git $HOME/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> $HOME/.zshrc
echo 'eval "$(rbenv init -)"' >> $HOME/.zshrc
exec $SHELL

git clone https://github.com/rbenv/ruby-build.git $HOME/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> $HOME/.zshrc
exec $SHELL

gem install bundler
get install pry
