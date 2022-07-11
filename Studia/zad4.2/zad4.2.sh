#!/bin/bash
# za pomoca cut (oraz sort i uniq) lub awk znajdz, przegladajac plik /etc/passwd jakie sa
# najpopularniejsze / najczesciej uzywane powloki oraz czestosc ich uzywania
cat /etc/shells | sed 's/^.*\///g' | sed '/^.*:.*/d' | uniq -c | sed 's/^.*[0-9]//g' > shells.txt
shells=shells.txt
ar=()
while IFS= read -r line
do
	ar+=($(echo $line))
done < "$shells"
max=0
maxstr=""
for value in "${ar[@]}";
do
	count=$(grep -o -E "/$value" /etc/passwd | uniq -c | sed 's/ //g')
        first=${count:0:1}
        if [ -z $first ]; then
		echo ""
		echo "Nie znaleziono wynikow dla $value:"
	else
		echo ""
                echo "Znaleziono $first wpis/y dla $value:"
                awk "/\/$value/{print}" /etc/passwd
		if [ "$max" -lt "$first" ]; then
			maxstr="$value"
			max="$first"
		fi
	fi
done
echo "________________________________________"
echo ""
echo "Najwiecej wynikow zanleziono dla $maxstr"
