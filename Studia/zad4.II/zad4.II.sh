#!/bin/bash
cat skrypt.sh > tocoment.txt
sed -n '/#!/,/@start/p' tocoment.txt | head -n -1 > up.txt
sed -n '/@end/,$ p' tocoment.txt | tail -n +2 > down.txt
sed -n -i '/@start/,/@end/p' tocoment.txt
sed -i 's/^/#/g' tocoment.txt
cat up.txt > skrypt.sh
cat tocoment.txt >> skrypt.sh
cat down.txt >> skrypt.sh
echo "Skrypt zostal zakomentowany"
cat skrypt.sh
sed -i 's/#//g' tocoment.txt
sed -i 's/@/#@/g' tocoment.txt
cat up.txt > skrypt.sh
cat tocoment.txt >> skrypt.sh
cat down.txt >> skrypt.sh
echo ""
echo "Skrypt zostal odkomentowany"
cat skrypt.sh

