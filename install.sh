#! /bin/bash

source $PWD/packages/packages.sh

read -p "Install ZSH (y/n)?" CONT
if [ "$CONT" == "y" ]; then
    source $PWD/shell/shell.sh
fi

read -p "Install Vim (y/n)?" CONT
if [ "$CONT" == "y" ]; then
    source $PWD/vim/vim.sh
fi

read -p "Install Tmux (y/n)?" CONT
if [ "$CONT" == "y" ]; then
    source $PWD/tmux/tmux.sh
fi

read -p "Install dotfiles (y/n)?" CONT
if [ "$CONT" == "y" ]; then
    source $PWD/dotfiles/dotfiles.sh
    sudo init 0
fi

read -p "Install Java (y/n)?" CONT
if [ "$CONT" == "y" ]; then
    source $PWD/java/java.sh
fi

read -p "Install Golang (y/n)?" CONT
if [ "$CONT" == "y" ]; then
    source $PWD/golang/golang.sh
fi

read -p "Install Apache (y/n)?" CONT
if [ "$CONT" == "y" ]; then
    source $PWD/apache/apache.sh
fi

read -p "Install Utils (y/n)?" CONT
if [ "$CONT" == "y" ]; then
    source $PWD/utils/utils.sh
fi

read -p "Install Clojure (y/n)?" CONT
if [ "$CONT" == "y" ]; then
    source $PWD/clojure/clojure.sh
fi

read -p "Install PHP(y/n)?" CONT
if [ "$CONT" == "y" ]; then
    source $PWD/php/php.sh
fi

read -p "Install MySQL (y/n)?" CONT
if [ "$CONT" == "y" ]; then
    source $PWD/mysql/mysql.sh
fi

read -p "Install NodeJs (y/n)?" CONT
if [ "$CONT" == "y" ]; then
    source $PWD/nodejs/nodejs.sh
fi

read -p "Update SSH config (y/n)?" CONT
if [ "$CONT" == "y" ]; then
    source $PWD/ssh/ssh.sh
fi

