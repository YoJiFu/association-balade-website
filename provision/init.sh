#!/bin/bash
# @author : bzhazreal <stanislas.david@mailoo.org>
# @TODO :
#   - configure php
#   - configure apache2 vhost
#   - configure mysql : auto install database

read -d '' VHOST << EOF
    <VirtualHost *:80>
    DocumentRoot "/var/www/html"

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined

    <Directory "/var/www/html">
        AllowOverride All
        Order allow,deny
        Allow from all
    </Directory>
</VirtualHost>
EOF

MYSQL_PASSWORD="root"
MYSQL_DATABASE_NAME="drupal"



function __update()
{
    echo "[ INFO ] - Start update system"
    sudo apt-get update
    sudo apt-get upgrade -y
    sudo apt-get dist-upgrade -y
    echo "[ INFO ] - End update system"
}

function __install_common()
{
    echo "[ INFO ] - Start Install Common"
    sudo apt-get install -y vim\
                            git
    echo "[ INFO ] - End install Common"
}

function __install_php_apache()
{
    echo "[ INFO ] - Start Install Php Apache"
    sudo apt-get update
    sudo apt-get install -y php7.0\
                            php7.0-xml\
                            php7.0-gd\
                            php7.0-mysql\
                            php7.0-zip\
                            php7.0-mbstring\
                            libapache2-mod-php7.0\
                            php7.0-bcmath\
                            php7.0-curl\
                            apache2
    echo "[ INFO ] - End install Php Apache"
}

function __install_mysql()
{
    sudo debconf-set-selections <<< "maria-db-$MARIADB_VERSION mysql-server/root_password password $MYSQL_PASSWORD"
    sudo debconf-set-selections <<< "maria-db-$MARIADB_VERSION mysql-server/root_password_again password $MYSQL_PASSWORD"
    sudo apt-get update
    sudo apt-get install -y mariadb-server
}

function __install_composer()
{
    cd /tmp
    sudo curl -sS https://getcomposer.org/installer | php
    sudo mv /tmp/composer.phar /usr/bin/composer
}

function __install_drush()
{
    cd /tmp
    sudo git clone https://github.com/drush-ops/drush.git /usr/local/src/drush
    sudo ln -s /usr/local/src/drush/drush /usr/bin/drush
    cd /usr/local/src/drush/
    sudo composer install
    sudo chmod +x /usr/bin/drush
}

function __configure_user()
{
    sudo usermod -aG www-data ubuntu
}

function __configure_apache2()
{
    sudo rm -f /etc/apache2/sites-available/*
    sudo rm -f /etc/apache2/sites-enabled/*
    sudo touch /etc/apache2/sites-available/drupal.conf
    sudo echo "$VHOST" > /etc/apache2/sites-available/drupal.conf
    sudo a2enmod rewrite
    sudo a2ensite drupal.conf
    sudo systemctl restart apache2
}

function __configure_mysql()
{
    echo "configure mysql"
    Q1="GRANT ALL ON *.* TO 'root'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD' WITH GRANT OPTION;"
    Q2="FLUSH PRIVILEGES;"
    Q3="CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE_NAME "
    SQL="${Q1}${Q2}${Q3}"
    mysql -u root -p$MYSQL_PASSWORD -e"$SQL"
    echo "end configure mysql"
}

function __install_front_end_tool()
{
    curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
    sudo apt-get install -y nodejs
}

function __install_front_tool()
{
    sudo apt-get install -y ruby\
                            ruby-dev\
                            make\
                            gcc
    sudo gem update --system
    sudo gem install compass
}

function main()
{
    echo "[ INFO ] - Start Initialisation of VM"
    __update
    __install_common
    __install_php_apache
    __install_mysql
    __install_composer
    __install_drush
    __install_front_tool
    __configure_apache2
    __configure_mysql
    __configure_user
    echo "[ INFO ] - End Initialisation of VM"
}

main