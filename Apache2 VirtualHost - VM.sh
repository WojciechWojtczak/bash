#!/bin/bash

read -p 'Podaj nazwę wirtualnego hosta: ' nazwa

# Tworzenie katalogu na pliki strony i nadanie odpowiednich uprawnień
mkdir -p "/var/www/$nazwa/html"
chown -R $USER:$USER "/var/www/$nazwa"
chmod -R 755 "/var/www/$nazwa"

# Tworzenie pliku konfiguracyjnego SSL dla wirtualnego hosta
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout "/var/www/$nazwa/ssl/$nazwa.private.key" \
  -out "/var/www/$nazwa/ssl/$nazwa.selfsigned.crt"

# Tworzenie pliku indeksu strony
cat > "/var/www/$nazwa/html/index.html" <<EOF
<html>
  <head>
    <title>Welcome to the page $nazwa!</title>
  </head>
  <body>
    <h1>You got Lucky! Your $nazwa server block is up!</h1>
  </body>
</html>
EOF

# Nadanie odpowiednich uprawnień plikowi indeksu strony
chmod 644 "/var/www/$nazwa/html/index.html"

# Tworzenie pliku konfiguracyjnego Apache dla wirtualnego hosta
read -p 'Podaj email administratora domeny: ' email
cat > "/etc/apache2/sites-available/$nazwa.conf" <<EOF
<VirtualHost *:80>
  ServerAdmin $email
  ServerName $nazwa
  ServerAlias www.$nazwa
  DocumentRoot /var/www/$nazwa/html
  <Directory /var/www/$nazwa/html>
    Options -Indexes +FollowSymLinks
    AllowOverride All
  </Directory>
  ErrorLog \${APACHE_LOG_DIR}/$nazwa-error.log
  CustomLog \${APACHE_LOG_DIR}/$nazwa-access.log combined
  SSLEngine on
  SSLCertificateFile    /var/www/$nazwa/ssl/$nazwa.selfsigned.crt
  SSLCertificateKeyFile /var/www/$nazwa/ssl/$nazwa.private.key
</VirtualHost>
EOF

# Włączenie nowego wirtualnego hosta i modułów Apache
a2ensite "$nazwa.conf"
a2enmod ssl headers

# Wyłączenie domyślnego wirtualnego hosta i restart serwera Apache
a2dissite 000-default.conf
systemctl restart apache2

# Test konfiguracji Apache
apache2ctl configtest

# Podpowiedź co zrobić dalej
echo "Na koniec dodaj w DNS te trzy linijki uzupełniając je o odpowiednie dane:"
echo "[nazwa_domeny] A [Adres IP serwera]"
echo "www.[nazwa_domeny] CNAME [nazwa_domeny]"
echo "*.[nazwa_domeny] A [Adres IP serwera]"
echo "lub w pliku /etc/hosts:"
echo "[Adres IP serwera] [nazwa_domeny]"
echo "dla każdej z domen"
