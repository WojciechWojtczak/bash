#!/bin/bash
#mapuje wskazaną sieć i wypisuje adresy IP i adresy MAC do pliku ip.csv. Struktura pliku to [ip] [MAC Addres]
sudo nmap -sn 192.168.x.x/24 | sed 's/ 1/\n1/g' | sed 's/^H.*//g' | sed 's/MAC Address: //g' | sed 's/^.*_gateway //g' | sed '/^$/d' | sed 's/^N.*//g' | sed 's/(1.*/192.168.100.1/g' | sed 's/(.*//g' | sed 's/^Sta.*//g' | sed 's/^.*CEST//g' | sed '/^$/d' | sed '2~2 s/$/\;/g' | sed '1~2 s/$/ /g' | sed -z 's/\n//g' | sed 's/;/\n/g' > ip.csv
#wypisanie danych i porównanie ich z przygotowaną bazą danych mac.csv. Struktura pliku to [MAC Adres] [Podana nazwa domyślnie ?]
while ISP="," read -r co1 co2
do
 if grep -F "$co2" mac.csv > trash;
 then
  while ISP="," read -r col1 col2
  do
   if [ "$co2" == "$col1" ];
   then
    echo "_______________________________________________________________________"
    echo "Mac addres $co2 jest powiązany z maszyną: $col2"
    echo "znajdziesz ją pod adresem IP: $co1"
    echo "_______________________________________________________________________"
   fi
  done < mac.csv
 else
  echo "_______________________________________________________________________"
  echo "MAC adres $co2 nie znajduje się w pliku mac.csv"
  echo "IP urządzenia: $co1"
  echo "Dopisuje MAC do pliku mac.csv"
  echo "$co2 ?" >> mac.csv
  echo "_______________________________________________________________________"
 fi
done < ip.csv
rm trash
