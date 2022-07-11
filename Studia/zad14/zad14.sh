#!/bin/bash
#ZAD. 14
#W plikach zrodlowych lub pojedynczym pliku wiekszego programu (np GitHub)
# w wybranym jezyku programowania wydobyc slowa kluczowe i przeanalizowac
# ich czestotliwosc wystepowania  
apropos git > lista.txt
#porzdkowanie danych
sed -i 's/git-//g' lista.txt
sed -i 's/(.*//g' lista.txt
sed -i 's/Net.*//g' lista.txt
sed -i '/-.*/d' lista.txt
sed -i '/^$/d' lista.txt
#tworzenie tabeli z wszystkimi danymi
input=lista.txt
ar1=()
ar=()
#petla wprowadajaca dane do tabeli
while IFS= read -r line
do
  ar1+=($(echo $line))
done < "$input"
echo "In manual of git comand we have:"
#petla wypisujaca dane w konsoli
for value in "${ar1[@]}"
do
	f=$(man git | grep -o $value | uniq -c)
	echo $f
	ar+=($(echo $f))
done
echo "The most comon keyworld is: "
max=$(echo "${ar[@]}" | grep -o -E '[0-9]+' | sort -nr | head -n1)
count=0
for item in " ${ar[@]} "; do
	count=$count+1
	if [ "$item" == "$max" ]; then
		echo "${ar[$count]}"
	fi
done

