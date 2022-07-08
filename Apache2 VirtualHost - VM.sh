#!/bin/bash

echo 'Podaj nazwę wirtualnego hosta'
read nazwa
mkdir -p /var/www/$nazwa/html
chown -R $USER:$USER /var/www/$nazwa/html
chmod -R 755 /var/www/$nazwa
chmod -R 755 /var/www/$nazwa/html
openssl req ‐x509 ‐nodes ‐days 365 ‐newkey rsa:2048 \ ‐keyout /var/www/$nazwa/ssl/$nazwa.private.key \ ‐out /var/www/$nazwa/ssl/$nazwa.selfsigned.crt 
echo '<html>' > /var/www/$nazwa/html/index.html
echo '<head>' >> /var/www/$nazwa/html/index.html
echo '<title>Welcome to the page '$nazwa'!</title>' >> /var/www/$nazwa/html/index.html
echo '</head>' >> /var/www/$nazwa/html/index.html
echo '<body>' >> /var/www/$nazwa/html/index.html
echo '<h1>You got Lucky! Your '$nazwa' server block is up!</h1>' >> /var/www/$nazwa/html/index.html
echo '</body>' >> /var/www/$nazwa/html/index.html
echo '</html>' >> /var/www/$nazwa/html/index.html
chmod 644 /var/www/$nazwa/html/index.html
echo '<VirtualHost *:80>' > /etc/apache2/sites-available/$nazwa.conf
echo 'Podaj email administratora domeny'
read email
echo ' ServerAdmin '$email >> /etc/apache2/sites-available/$nazwa.conf
echo ' ServerName '$nazwa >> /etc/apache2/sites-available/$nazwa.conf
echo ' ServerAlias www.'$nazwa >> /etc/apache2/sites-available/$nazwa.conf
echo ' DocumentRoot /var/www/'$nazwa'/html' >> /etc/apache2/sites-available/$nazwa.conf
echo ' <Directory /var/www/sites/KATALOG_DOMENY/www >' >> /etc/apache2/sites-available/$nazwa.conf
echo '  Options ‐Indexes +FollowSymLinks' >> /etc/apache2/sites-available/$nazwa.conf
echo '  AllowOverride All' >> /etc/apache2/sites-available/$nazwa.conf
echo ' </Directory>' >> /etc/apache2/sites-available/$nazwa.conf
echo ' ErrorLog ${APACHE_LOG_DIR}/'$nazwa'-error.log' >> /etc/apache2/sites-available/$nazwa.conf
echo ' CustomLog ${APACHE_LOG_DIR}/'$nazwa'-access.log combined' >> /etc/apache2/sites-available/$nazwa.conf
echo ' SSLEngine on' >> /etc/apache2/sites-available/$nazwa.conf
echo ' SSLCertificateFile    /var/www/$nazwa/ssl/$nazwa.selfsigned.crt' >> /etc/apache2/sites-available/$nazwa.conf
echo ' SSLCertificateKeyFile /var/www/$nazwa/ssl/$nazwa.private.key' >> /etc/apache2/sites-available/$nazwa.conf
echo '</VirtualHost>' >> /etc/apache2/sites-available/$nazwa.conf
 
a2ensite $nazwa.conf
a2enmod ssl 
a2enmod headers
a2dissite 000-default.conf
systemctl restart apache2
apache2ctl configtest

echo 'Na koniec dodaj w DNS te trzy linijki uzupełniając je o odpowiednie dane'
echo '[nazwa_domeny] A [Adres IP serwera]'
echo 'www.[nazwa_domeny] CNAME [nazwa_domeny]'
echo '*.[nazwa_domeny] A [Adres IP serwera]'
echo 'lub w pliku /etc/hosts:'
echo '[Adres IP serwera] [nazwa_domeny]'
echo 'dla każdej z domen'