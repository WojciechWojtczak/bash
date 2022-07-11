#!/bin/bash
#Opisac trzy wyrazenia regularne, ktore potrafia dopasowac liczby w takiej postaci, w jakiej wystepuja w tekscie
echo "Podaj liczbe:"
read liczba
if grep -q "\." <<< $liczba && grep -q -v "e" <<< $liczba && grep -q -v "E" <<< $liczba; then
	echo "Jest to liczba zmiennoprzecinkowa"
elif grep -q "e" <<< $liczba || grep -q "E" <<< $liczba; then
	echo "Jest to liczba w notacji naukowej"
else
	echo "Jest to liczba calkowita"
fi
