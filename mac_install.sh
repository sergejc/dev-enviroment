#! /bin/bash

xcode-select --install

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install caskroom/cask/brew-cask

brew install git
brew cask install vagrant
brew cask install virtualbox

brew install docker
brew install docker-compose
brew install leiningen
brew install pstree
brew install elm
