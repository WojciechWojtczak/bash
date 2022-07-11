#!/bin/bash
#ZAD 16
curl -s "https://www.gutenberg.org/ebooks/search/?query=$1&submit_search=Go!" > book.txt 
link=$(cat book.txt | grep 'class="booklink"' -A 1 | sed 's/^<li.*link">//g' | sed 's/<a.*href="//g' | sed 's/".*>//g' | sed '/^$/d' | head -n 1)
curl -s "https://www.gutenberg.org/$link" > book.txt
link=$(cat book.txt | grep 'Plain Text UTF-8' | sed 's/^.*href="//g' | sed 's/" type.*//g')
curl -s "https://www.gutenberg.org/$link" > book.txt
title=$(cat book.txt | grep "title" | sed 's/<title>//g' | sed 's/<\/.*//g')
if [[ $title == "302 Found" ]]; then
	link=$(cat book.txt | grep "<p>" | sed 's/<p>.*href="//g' | sed 's/">.*//g')
	curl -s "$link" > book.txt
fi
echo "Najczesciej wystepujace slowa w podanej ksiazce"
sed -e 's/\s/\n/g' < book.txt | sort | uniq -c | sort -nr | head  -10
