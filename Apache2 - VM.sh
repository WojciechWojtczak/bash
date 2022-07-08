#!/bin/bash

apt update
apt install –y apache2 
apt install -y links
apt install -y ufw
echo "PRZEPRASZAMY <br> STRONA W BUDOWIE" > /var/www/html/index.htm
sed -i -e "s/ServerTokens OS/ServerTokens Prod/" /etc/apache2/conf-available/security.conf
sed -i -e "s/ServerSignature On/ServerSignature Off/" /etc/apache2/conf-available/security.conf
ufw allow 80/tcp
ufw allow 443/tcp
