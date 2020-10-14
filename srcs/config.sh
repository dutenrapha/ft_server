#!/bin/bash

#nginx configuration
cp /tmp/nginx/nginx.conf /etc/nginx/sites-available/nginx.conf

ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/

unlink /etc/nginx/sites-enabled/default

#php  configuration
# Test if PHP was installed correctly
# cp /tmp/php/info.php /var/www/html/info.php

#mysql configuration
service mysql start
mysql -e "CREATE DATABASE phpmyadmin;"
mysql -e "CREATE DATABASE wordpress;"