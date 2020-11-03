#!/bin/bash

## nginx configuration
# Send nginx.confto the right place 
cp /tmp/nginx/nginx.conf /etc/nginx/sites-available/nginx.conf

# Link nginx.conf with sites-enabled
ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/

# Unink default from sites-enabled
unlink /etc/nginx/sites-enabled/default

##php configuration
# Test if PHP was installed correctly
cp /tmp/php/info.php /var/www/html/info.php
wget -P tmp https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz
mkdir /var/www/html/phpmyadmin
cd tmp
tar xvf phpMyAdmin-latest-all-languages.tar.gz --strip-components=1 -C /var/www/html/phpmyadmin
rm -fR phpMyAdmin-latest-all-languages.tar.gz
cp config.inc.php /var/www/html/phpmyadmin/config.inc.php
chmod 660 /var/www/html/phpmyadmin/config.inc.php

## mysql configuration
USER=user
service mysql start
mysql -e "CREATE USER '$USER' IDENTIFIED BY '$USER';"
mysql -e "CREATE DATABASE phpmyadmin;"
mysql -e "CREATE DATABASE wordpress;"
mysql -e "GRANT ALL PRIVILEGES ON *.* TO '$USER';"

## SSL configuration
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-subj '/C=BR/ST=SP/L=SP/O=42/OU=SP/CN=rdutenke' \
	-keyout /etc/ssl/private/nginx-selfsigned.key \
	-out /etc/ssl/private/nginx-selfsigned.crt

## Wordpress
cd /tmp
curl -LO https://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz
cp /tmp/wordpress/wp-config-sample.php /tmp/wordpress/wp-config.php
cp -a /tmp/wordpress/. /var/www/html/
chown -R www-data:www-data /var/www/html/
curl -s https://api.wordpress.org/secret-key/1.1/salt/ > credentials.txt
mv credentials.txt /var/www/html/
cd /var/www/html/
sed 's/database_name_here/wordpress/g' /var/www/html/wp-config.php > tmpfile && mv tmpfile wp-config.php
sed 's/username_here/user/g' /var/www/html/wp-config.php > tmpfile && mv tmpfile wp-config.php
sed 's/password_here/user/g' /var/www/html/wp-config.php > tmpfile && mv tmpfile wp-config.php

sed "/\/\*\*\#\@\-\*/i define\('FS_METHOD', 'direct'\);" /var/www/html/wp-config.php > tmpfile && mv tmpfile wp-config.php

sed '/put your unique phrase here/d' /var/www/html/wp-config.php > tmpfile && mv tmpfile wp-config.php

sed '/\/\*\*\#\@\-\*/r credentials.txt' /var/www/html/wp-config.php > tmpfile && mv tmpfile wp-config.php
rm -f credentials.txt

mkdir autoindex
