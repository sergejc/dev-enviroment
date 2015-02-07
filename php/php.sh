#!/bin/zsh

# PHP
sudo add-apt-repository ppa:ondrej/php5-5.6 && sudo apt-get update
sudo apt-get install \
    php5 php5-cli php5-curl php5-gd php5-json \
    php5-memcache php5-readline php5-sqlite \
    php5-mcrypt php5-memcached php5-mongo \
    php5-mysqlnd php5-dev php5-xsl php5-pgsql \
    php5-imap php5-imagick php5-redis php-pear \
    libapache2-mod-php5 php5-openssl -y

# Composer
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# PHP Copy/Paste Detector
echo "php copy/past detector"
composer global require 'sebastian/phpcpd=*'

# PHP_CodeSniffer
echo "php codesniffer"
composer global require "squizlabs/php_codesniffer=*"

# Codecept
echo "codeception"
composer global require 'codeception/codeception=*'

# PHPUnit
echo "phpunit"
composer global require "phpunit/phpunit=*"

# PHP Mess Detector
echo "php mess detector"
composer global require "phpmd/phpmd"

# PHPLOC
echo "phploc"
composer global require 'phploc/phploc=*'

# PHP Dead Code Detector
echo "php dead code detector"
composer global require 'sebastian/phpdcd=*'

# Boris CLI
echo "boris"
composer global require 'd11wtq/boris=*'

# PHP Xdebug
sudo pecl install xdebug

# APACHE php.ini
PHP_APACHE_INI="/etc/php5/apache2/php.ini"
sudo sed -i "s|; date.timezone =|date.timezone = Europe/London|" $PHP_APACHE_INI
sudo sed -i "s|^display_errors = Off|display_errors = On|" $PHP_APACHE_INI
sudo sed -i "s|^display_startup_errors = Off|display_startup_errors = On|" $PHP_APACHE_INI
sudo sed -i "s|^post_max_size = 8M|post_max_size = 16M|" $PHP_APACHE_INI
sudo sed -i "s|^upload_max_filesize = 2M|upload_max_filesize = 16M|" $PHP_APACHE_INI
sudo sed -i "s|^; max_input_vars = 1000|max_input_vars = 10000|" $PHP_APACHE_INI

cat << EOF | sudo tee -a $PHP_APACHE_INI

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

# CLI php.ini
PHP_CLI_INI="/etc/php5/cli/php.ini"
sudo sed -i "s|; date.timezone =|date.timezone = Europe/London|" $PHP_CLI_INI
sudo sed -i "s|^display_errors = Off|display_errors = On|" $PHP_CLI_INI
sudo sed -i "s|^display_startup_errors = Off|display_startup_errors = On|" $PHP_CLI_INI
sudo sed -i "s|^post_max_size = 8M|post_max_size = 16M|" $PHP_CLI_INI
sudo sed -i "s|^upload_max_filesize = 2M|upload_max_filesize = 16M|" $PHP_CLI_INI
sudo sed -i "s|^; max_input_vars = 1000|max_input_vars = 10000|" $PHP_CLI_INI 

cat << EOF | sudo tee -a $PHP_CLI_INI

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
