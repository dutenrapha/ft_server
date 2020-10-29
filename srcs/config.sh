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

## mysql configuration
service mysql start
mysql -e "CREATE DATABASE phpmyadmin;"
mysql -e "CREATE DATABASE wordpress;"

## SSL configuration
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-subj '/C=BR/ST=SP/L=SP/O=42/OU=SP/CN=rdutenke' \
	-keyout /etc/ssl/private/nginx-selfsigned.key \
	-out /etc/ssl/private/nginx-selfsigned.crt
