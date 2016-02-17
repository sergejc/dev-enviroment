#! /bin/bash

source $PWD/packages/packages.sh

read -p "Install Mutt (y/n)?" CONT
if [ "$CONT" == "y" ]; then
    source $PWD/mail/mail.sh
fi

read -p "Install Apache (y/n)?" CONT
if [ "$CONT" == "y" ]; then
    source $PWD/apache/apache.sh
fi

read -p "Install Utils (y/n)?" CONT
if [ "$CONT" == "y" ]; then
    source $PWD/utils/utils.sh
fi

read -p "Install PHP(y/n)?" CONT
if [ "$CONT" == "y" ]; then
    source $PWD/php/php.sh
fi

read -p "Install MySQL (y/n)?" CONT
if [ "$CONT" == "y" ]; then
    source $PWD/mysql/mysql.sh
fi

read -p "Install ZSH (y/n)?" CONT
if [ "$CONT" == "y" ]; then
    source $PWD/shell/shell.sh
fi

read -p "Install NodeJs (y/n)?" CONT
if [ "$CONT" == "y" ]; then
    source $PWD/nodejs/nodejs.sh
fi

read -p "Install dotfiles (y/n)?" CONT
if [ "$CONT" == "y" ]; then
    source $PWD/dotfiles/dotfiles.sh
fi

read -p "Install Vim (y/n)?" CONT
if [ "$CONT" == "y" ]; then
    source $PWD/vim/vim.sh
fi

read -p "Update SSH config (y/n)?" CONT
if [ "$CONT" == "y" ]; then
    source $PWD/ssh/ssh.sh
fi

sudo init 0
