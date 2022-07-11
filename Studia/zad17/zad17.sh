#!/bin/bash
#zad17
curl -s "https://www.gutenberg.org/browse/scores/top" > web.txt
echo "Oto 5 najczesciej pobiernych ksiazek:"
cat web.txt | grep 'id="books-last1"' -A 7 | sed 's/^<h.*//g' | sed 's/<ol>//g' | sed 's/^<l.*">//g' | sed 's/<\/.*//g' | sed '/^$/d'
