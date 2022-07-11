#!/bin/bash
#Stworzyc wyrazenie regularne, ktore potrafi dopasowac dowolny adres serwera internetowego, 
#np. wystepujacy jako link/tekst na dowolnej stronie internetowej.
clear
echo "Podaj adres strony internetowej"
read link
clear
protokol=$(echo $link | sed 's/:.*//g')
echo ""
echo "Protokol: $protokol"
last=${protokol: -1}
if [ $last == "s" ]; then
	echo "Poloczenie jest szyfrowane"
else
	echo "Poloczenie nie jest szyfrowane"
fi
domena=$(echo $link | sed 's/^.*\/\///g')
domena=$(echo $domena | sed 's/\/.*//g')
check=":"
if grep -q ":" <<< "$domena"; then 
	port=$(echo $domena | sed 's/^.*.://g')
	domena=$(echo $domena | sed 's/:.*//g')
	echo ""
	echo "Domena: $domena"
	echo ""
	echo "Port: $port"
else
        echo ""
	echo "Domena: $domena"
        echo ""
	echo "Port: brak informacji"
fi
katalog=$(echo $link | sed 's/^.*.\///g' | sed 's/?.*//g')
echo ""
echo "Sciezka do pliku: $katalog"
zapytania=$(echo $link |sed 's/^.*?//g' | sed 's/#.*//g' )
echo ""
echo "Zapytania: "
echo $zapytania | sed 's/&/\n/g' | sed 's/=/ = /g'
echo ""
echo "Fragmenty: "
if grep -q "#" <<< $link; then
	fragmenty=$(echo $link |sed 's/^.*#//g')
	echo $fragmenty
else
	echo "Brak informacji"
fi
