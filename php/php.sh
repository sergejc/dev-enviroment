#!/bin/bash

# Locale
locale -a | grep -q en_GB.utf8 || sudo locale-gen en_GB.utf8

# PHP
filename='/etc/apt/sources.list.d/ondrej-ubuntu-php5-5_6-utopic.list'
if [ ! -f $filename ]; then
    sudo add-apt-repository ppa:ondrej/php5-5.6 -y && sudo apt-get update
fi

sudo apt-get install \
    php5 php5-cli php5-curl php5-gd php5-json \
    php5-memcache php5-readline php5-sqlite \
    php5-mcrypt php5-memcached php5-mongo \
    php5-mysqlnd php5-dev php5-xsl php5-pgsql \
    php5-imap php5-imagick php5-redis php-pear \
    libapache2-mod-php5 -y

# Composer
filename='/usr/local/bin/composer'
if [ ! -f $filename ]; then
    curl -sS https://getcomposer.org/installer | php
    sudo mv composer.phar $filename 
fi


# PHP Copy/Paste Detector
filename="$HOME/.composer/vendor/bin/phpcpd" 
if [ ! -L $filename ]; then
    echo "php copy/past detector"
    composer global require 'sebastian/phpcpd=*'
fi

# PHP_CodeSniffer
filename="$HOME/.composer/vendor/bin/phpcs"
if [ ! -L $filename ]; then
    echo "php codesniffer"
    composer global require "squizlabs/php_codesniffer=*"
fi

filename="$HOME/.composer/vendor/bin/phpcbf"
if [ ! -L $filename ]; then
    echo "php codesniffer"
    composer global require "squizlabs/php_codesniffer=*"
fi

# Codecept
filename="$HOME/.composer/vendor/bin/codecept"
if [ ! -L $filename ]; then
    echo "codeception"
    composer global require 'codeception/codeception=*'
fi

# PHPUnit
filename="$HOME/.composer/vendor/bin/phpunit"
if [ ! -L $filename ]; then
    echo "phpunit"
    composer global require "phpunit/phpunit=*"
fi

# PHP Mess Detector
filename="$HOME/.composer/vendor/bin/phpmd"
if [ ! -L $filename ]; then
    echo "php mess detector"
    composer global require "phpmd/phpmd"
fi

# PHPLOC
filename="$HOME/.composer/vendor/bin/phploc"
if [ ! -L $filename ]; then
    echo "phploc"
    composer global require 'phploc/phploc=*'
fi

# PHP Dead Code Detector
filename="$HOME/.composer/vendor/bin/phpdcd"
if [ ! -L $filename ]; then
    echo "php dead code detector"
    composer global require 'sebastian/phpdcd=*'
fi

# Boris CLI
filename="$HOME/.composer/vendor/bin/boris"
if [ ! -L $filename ]; then
    echo "boris"
    composer global require 'd11wtq/boris=*'
fi


# APACHE php.ini
PHP_APACHE_INI="/etc/php5/apache2/php.ini"
if ! grep -q xdebug $PHP_APACHE_INI; then
    sudo sed -i "s|; date.timezone =|date.timezone = Europe/London|" $PHP_APACHE_INI
    sudo sed -i "s|^display_errors = Off|display_errors = On|" $PHP_APACHE_INI
    sudo sed -i "s|^display_startup_errors = Off|display_startup_errors = On|" $PHP_APACHE_INI
    sudo sed -i "s|^post_max_size = 8M|post_max_size = 16M|" $PHP_APACHE_INI
    sudo sed -i "s|^upload_max_filesize = 2M|upload_max_filesize = 16M|" $PHP_APACHE_INI
    sudo sed -i "s|^; max_input_vars = 1000|max_input_vars = 10000|" $PHP_APACHE_INI

PHP_XDEBUG_INI="/etc/php5/mods-available/xdebug.ini"
cat << EOF | sudo tee -a $PHP_XDEBUG_INI

[xdebug]
zend_extension=xdebug.so

xdebug.remote_connect_back = 1
xdebug.remote_enable=true
xdebug.cli_color=2
xdebug.show_local_vars=1
xdebug.max_nesting_level=1000
; xdebug.scream=1
; xdebug.profiler_enable=1
; xdebug.profile_output_dir=/tmp
EOF
fi

# CLI php.ini
PHP_CLI_INI="/etc/php5/cli/php.ini"
if ! grep -q xdebug $PHP_CLI_INI; then
    sudo sed -i "s|; date.timezone =|date.timezone = Europe/London|" $PHP_CLI_INI
    sudo sed -i "s|^display_errors = Off|display_errors = On|" $PHP_CLI_INI
    sudo sed -i "s|^display_startup_errors = Off|display_startup_errors = On|" $PHP_CLI_INI
    sudo sed -i "s|^post_max_size = 8M|post_max_size = 16M|" $PHP_CLI_INI
    sudo sed -i "s|^upload_max_filesize = 2M|upload_max_filesize = 16M|" $PHP_CLI_INI
    sudo sed -i "s|^; max_input_vars = 1000|max_input_vars = 10000|" $PHP_CLI_INI 

cat << EOF | sudo tee -a $PHP_CLI_INI

[xdebug]
zend_extension=xdebug.so

xdebug.remote_enable=true
xdebug.remote_connect_back = 1
xdebug.max_nesting_level=1000
xdebug.cli_color=2
xdebug.show_local_vars=1
; xdebug.profiler_enable=1
; xdebug.profile_output_dir=/tmp
; xdebug.scream=1
EOF
fi

# PHP Xdebug
php -v | grep -q Xdebug || sudo pecl install xdebug
