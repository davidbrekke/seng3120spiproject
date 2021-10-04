#!/bin/sh
apt update
apt install -y apache2
apt install php libapache2-mod-php php-mysql -y 
systemctl restart apache2.service