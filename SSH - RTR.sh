#!/bin/bash

#Zmiana konfiguracji ssh
sed -i -e 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
#Restart usługi
systemctl restart sshd
#Wygenerowanie klucza
ssh‐keygen –b 2048 –t rsa
#Przesłanie go do zdalnych hostów
for ip in 101 102 103; do
    ssh-copy-id 192.168.10.$ip
done
