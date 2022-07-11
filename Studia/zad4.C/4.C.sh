#!/bin/bash
getent group | sed "s/:.*//g" > groups.txt
getent passwd | sed "s/:.*//g" > users.txt

gr=groups.txt
us=users.txt

group=()
user=()
echo "" > dane.txt

while IFS= read -r line
do
	group+=($(echo $line))
done < "$gr"
while IFS= read -r line
do
	user+=($(echo $line))
done < "$us"
for a in "${group[@]}";
do
	cd $1
	count=$(find -group $a | wc -l)
	if [ $count != 0 ]; then
		echo "W folderze $1 znajduje sie $count plikow grupy $a"
        	echo "$a $count" > dane.txt
	fi
done
for b in "${user[@]}";
do
        cd $1
        count=$(find -user $b | wc -l)
        if [ $count != 0 ]; then
                echo "W folderze $1 znajduje sie $count uzytkownika $b"
		echo "$b $count" > dane.txt
        fi
done
