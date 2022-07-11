#!/bin/bash
#napisac zastepstwo polecenia powloki rm, ktore bedzie zapisywalo log operacji usuwania plikow,
# logujac nazwe uzytkownika i date usuniecia pliku, samo usuwanie bedie odbywac sie za pomoca polecenia /user/bin/rm
now=$(date)
echo "--------------------------" >> log.txt
echo "$now" >> log.txt
echo "User: $USER" >> log.txt
echo "Lista usunietych plikow:" >> log.txt
lok=$(pwd)
for par in $@; do
	if [ -f "$par" ]; then
		/usr/bin/rm $par
		echo "Usunito plik $par"
		echo "- $lok/$par" >> log.txt
	else
		echo "Plik $par nie znajduje sie w tym folderze"
	fi
done
