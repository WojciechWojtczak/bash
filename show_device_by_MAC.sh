#!/bin/bash

# Mapowanie sieci i wypisanie adresów IP i MAC do pliku ip.csv. Struktura pliku to [ip] [MAC Adres]
sudo nmap -sn 192.168.x.x/24 | awk '/^Nmap/{ip=$NF}/MAC Address:/{print ip,$NF}' | sed 's/_gateway//g' | sed 's/(\(.*\))/\1/g' | sed '/^$/d' > ip.csv

# Porównanie danych z plikiem mac.csv i wypisanie wyników. Struktura pliku to [MAC Adres] [Podana nazwa domyślnie ?]
while IFS=, read -r ip mac_name || [ -n "$ip" ]
do
    if grep -Fq "$mac_name" mac.csv; then
        mac_address=$(grep -F "$mac_name" mac.csv | awk '{print $1}')
        echo "_______________________________________________________________________"
        echo "Adres MAC $mac_address jest powiązany z maszyną: $mac_name"
        echo "znajdziesz ją pod adresem IP: $ip"
        echo "_______________________________________________________________________"
    else
        echo "_______________________________________________________________________"
        echo "Adres MAC $mac_name nie znajduje się w pliku mac.csv"
        echo "IP urządzenia: $ip"
        echo "Dopisuje MAC do pliku mac.csv"
        echo "$mac_address $mac_name ?" >> mac.csv
        echo "_______________________________________________________________________"
    fi
done < ip.csv

# Usuwanie pliku tymczasowego
rm ip.csv
