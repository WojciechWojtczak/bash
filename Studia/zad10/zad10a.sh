#!/bin/bash
#Napisz program, ktory bedzie sprawdzac czy argument lub argumenty (lub wartosci wprowadzone
# za pomoca polecenia read) skladaja sie wylacznie ze znakow alfanumerycznych
echo "Podaj ciag znakow"
read str
if grep -q "[0-9]" <<< $str; then
	echo "Liczba nie jest alfanumeryczna"
else
	echo "Liczna jest alfanumeryczna"
fi
