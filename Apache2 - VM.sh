#!/bin/bash

# Sprawdzamy, czy użytkownik ma uprawnienia do uruchomienia skryptu jako root
if [ "$(whoami)" != "root" ]; then
  echo "Aby uruchomić ten skrypt, musisz mieć uprawnienia administratora. Proszę uruchom ponownie z konta root."
  exit 1
fi

# Instalujemy serwer Apache, przeglądarkę Links oraz narzędzie UFW
apt update && apt install -y apache2 links ufw

# Tworzymy prostą stronę w budowie
echo "PRZEPRASZAMY <br> STRONA W BUDOWIE" > /var/www/html/index.html

# Konfigurujemy bezpieczeństwo serwera Apache
sed -i -e "s/ServerTokens OS/ServerTokens Prod/" /etc/apache2/conf-available/security.conf
sed -i -e "s/ServerSignature On/ServerSignature Off/" /etc/apache2/conf-available/security.conf

# Konfigurujemy narzędzie UFW
ufw allow 80/tcp
ufw allow 443/tcp
ufw enable

# Restartujemy serwer Apache, aby zastosować zmiany w konfiguracji
systemctl restart apache2

# Wyświetlamy komunikat o sukcesie
echo "Serwer Apache został zainstalowany i skonfigurowany."
