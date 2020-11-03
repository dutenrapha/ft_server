#!/bin/bash

nginx_file='/etc/nginx/sites-available/nginx.conf'

grep "autoindex on;" "$nginx_file" > /dev/null
if [ $? -eq 0 ]; then
	echo "Autoindex ligado"
	sed -i 's/autoindex on/autoindex off/' "$nginx_file"
	autoindex="OFF";
else
	echo "Autoindex desligado"
	sed -i "s/autoindex off/autoindex on/" "$nginx_file"
	autoindex="ON";
fi
echo "Reiniciando o servidor, para finalizar a troca do autoindex"
service nginx restart
echo "Servidor ligado"
echo "O autoindex esta $autoindex"