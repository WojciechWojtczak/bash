#!/bin/bash
#Wyobraz sobie liste nazwisk wraz z data urodzenia (imie i nazwisko rozdzielone spacjami, nazwisko
#i data tabulatorem tzn. znakiem \"\/t\"
#Opisac wyrazenie regularne ktore znajdzie te daty urodzenia, w ktorych dzien i miesiac sa takie same.
while IFS="	" read -r rec_columna1 rec_columna2
do
	day=$(echo $rec_columna2 | sed 's/\..*//g')
	month=$(echo $rec_columna2 | sed 's/^...//g' | sed 's/\..*//g')
	if [ "$day" == "$month" ]; then
		echo "$rec_columna1 $rec_columna2"
	fi
done < <(tail dane.txt)
