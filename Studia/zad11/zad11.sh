#!/bin/bash
#Napisz program, ktory podany numer wypisuje z odpowiednim separatorem tysiecy oraz odpowiednim 
# symbolem kropki dziesietnej.
echo "Podaj liczbe"
read int
if grep -q "," <<< $int; then
	tys=$(echo $int | sed 's/,.*//g')
	dzie=$(echo $int | sed 's/^.*,//g')
	tys=$(echo $tys | sed ':a;s/\B[0-9]\{3\}\>/,&/;ta')
	echo "$tys.$dzie"
elif grep -q "\." <<< $int; then
	tys=$(echo $int | sed 's/\..*//g')
        dzie=$(echo $int | sed 's/^.*\.//g')
        tys=$(echo $tys | sed ':a;s/\B[0-9]\{3\}\>/,&/;ta')
        echo "$tys.$dzie"
else
	echo $int | sed ':a;s/\B[0-9]\{3\}\>/,&/;ta'
fi


