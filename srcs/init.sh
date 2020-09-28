USER=admin
service mysql start
mysql -e "CREATE USER '$USER' IDENTIFIED BY '$USER';"
mysql -e "GRANT ALL PRIVILEGES ON *.* TO '$USER';"