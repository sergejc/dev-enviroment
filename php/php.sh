#!/bin/bash

while sudo fuser /var/lib/dpkg/lock >/dev/null 2>&1; do
    sleep 1
done

# Locale
locale -a | grep -q en_GB.utf8 || sudo locale-gen en_GB.utf8

sudo apt install \
php php7.0-curl php7.0-gd \
php7.0-sqlite3 php7.0-mcrypt php-memcached \
php7.0-mysql php7.0-dev php7.0-pgsql \
php7.0-imap php-redis php-pear \
php7.0-mbstring php7.0-bz2 php7.0-zip \
libapache2-mod-php7.0 -y

# Composer
filename='/usr/local/bin/composer'
if [ ! -f $filename ]; then
    echo "composer"
    curl -sS https://getcomposer.org/installer | php
    sudo mv composer.phar $filename
fi

# PHP_CodeSniffer
filename="/usr/local/bin/phpcs"
if [ ! -f $filename ]; then
    echo "php codesniffer (phpcs)"
    wget https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar
    chmod u+x phpcs.phar
    sudo mv phpcs.phar $filename
fi

# PHP_CodeSniffer
filename="/usr/local/bin/phpcbf"
if [ ! -f $filename ]; then
    echo "php codesniffer (phpcbf)"
    wget https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar
    chmod u+x phpcbf.phar
    sudo mv phpcbf.phar $filename
fi

# PHPUnit
filename="/usr/local/bin/phpunit"
if [ ! -f $filename ]; then
    echo "phpunit"
    wget https://phar.phpunit.de/phpunit.phar
    chmod u+x phpunit.phar
    sudo mv phpunit.phar $filename
fi

# PHP Copy/Paste Detector
filename="/usr/local/bin/phpcpd"
if [ ! -f $filename ]; then
    echo "php copy/past detector"
    wget https://phar.phpunit.de/phpcpd.phar
    chmod u+x phpcpd.phar
    sudo mv phpcpd.phar $filename
fi

# phpDox - The PHP Documentation Generator
filename="/usr/local/bin/phpdox"
if [ ! -f $filename ]; then
    echo "phpDox "
    wget http://phpdox.de/releases/phpdox.phar
    chmod u+x phpdox.phar
    sudo mv phpdox.phar $filename
fi

# PDepend
filename="/usr/local/bin/pdepend"
if [ ! -f $filename ]; then
    echo "pdepend"
    wget http://static.pdepend.org/php/latest/pdepend.phar
    chmod u+x pdepend.phar
    sudo mv pdepend.phar $filename
fi

# PHPLOC
filename="/usr/local/bin/phploc"
if [ ! -f $filename ]; then
    echo "phploc"
    wget https://phar.phpunit.de/phploc.phar
    chmod u+x phploc.phar
    sudo mv phploc.phar $filename
fi

# PHP Mess Detector
filename="/usr/local/bin/phpmd"
if [ ! -f $filename ]; then
    echo "php mess detector"
    wget http://static.phpmd.org/php/latest/phpmd.phar
    chmod u+x phpmd.phar
    sudo mv phpmd.phar $filename
fi

# PHP Dead Code Detector
filename="/usr/local/bin/phpdcd"
if [ ! -f $filename ]; then
    echo "php dead code detector"
    wget https://phar.phpunit.de/phpdcd.phar
    chmod u+x phpdcd.phar
    sudo mv phpdcd.phar $filename
fi

# Boris CLI
filename="$HOME/.config/composer/vendor/bin/boris"
if [ ! -L $filename ]; then
    echo "boris"
    composer global require 'd11wtq/boris=*'
fi


# PHP Xdebug
filename="/etc/php/7.0/mods-available/xdebug.ini"
if [ ! -L $filename ]; then
cat << EOF | sudo tee -a $filename
[xdebug]
zend_extension=xdebug.so

xdebug.remote_connect_back = 1
xdebug.remote_enable=true
xdebug.cli_color=2
xdebug.show_local_vars=1
xdebug.max_nesting_level=1000
xdebug.remote_autostart=1
; xdebug.scream=1
; xdebug.profiler_enable=1
; xdebug.profile_output_dir=/tmp
EOF

php -v | grep -q Xdebug || sudo pecl install xdebug && sudo phpenmod xdebug
fi


# APACHE php.ini
PHP_APACHE_INI="/etc/php/7.0/apache2/php.ini"
if ! grep -q 'max_input_vars = 10000' $PHP_APACHE_INI; then
    sudo sed -i "s|; date.timezone =|date.timezone = Europe/London|" $PHP_APACHE_INI
    sudo sed -i "s|^display_errors = Off|display_errors = On|" $PHP_APACHE_INI
    sudo sed -i "s|^display_startup_errors = Off|display_startup_errors = On|" $PHP_APACHE_INI
    sudo sed -i "s|^post_max_size = 8M|post_max_size = 16M|" $PHP_APACHE_INI
    sudo sed -i "s|^upload_max_filesize = 2M|upload_max_filesize = 16M|" $PHP_APACHE_INI
    sudo sed -i "s|^; max_input_vars = 1000|max_input_vars = 10000|" $PHP_APACHE_INI
fi

# CLI php.ini
PHP_CLI_INI="/etc/php/7.0/cli/php.ini"
if ! grep -q 'max_input_vars = 10000' $PHP_CLI_INI; then
    sudo sed -i "s|; date.timezone =|date.timezone = Europe/London|" $PHP_CLI_INI
    sudo sed -i "s|^display_errors = Off|display_errors = On|" $PHP_CLI_INI
    sudo sed -i "s|^display_startup_errors = Off|display_startup_errors = On|" $PHP_CLI_INI
    sudo sed -i "s|^post_max_size = 8M|post_max_size = 16M|" $PHP_CLI_INI
    sudo sed -i "s|^upload_max_filesize = 2M|upload_max_filesize = 16M|" $PHP_CLI_INI
    sudo sed -i "s|^; max_input_vars = 1000|max_input_vars = 10000|" $PHP_CLI_INI 
fi

sudo apt autoremove -y
