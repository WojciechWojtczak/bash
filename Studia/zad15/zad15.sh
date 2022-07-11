#!/bin/bash
curl https://www.gutenberg.org/files/19033/19033-h/19033-h.htm > book.pdf
cat book.pdf | grep "<h2>" | sed "s/^<h2>.*;//g" | sed "s/<\/h2>/ /g" > chapters.txt
chapters.txt
echo ""
echo "Oto rozdzialy ksiazki:"
cat chapters.txt
echo ""
for b in {a..z};
do
	count=$(cat book.pdf | grep $b | wc -l)
	echo "W ksiazce znajduej sie $count liter $b"
done
for c in {A..Z};
do 
        count=$(cat book.pdf | grep $c | wc -l)
        echo "W ksiazce znajduej sie $count liter $c"
done
