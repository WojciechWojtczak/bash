#!/bin/bash
#Z pliku w formacie CSV listy studentow zapisanych w=do grupy wudobyc imiona i nazwiska (bez drugiego imienia)
#w formacie \"Imie nazwisko\":

while IFS=";" read -r rec_column1 rec_column2
do
        echo "$rec_column2 $rec_column1" | sed 's/"//g'
done < <(tail -n +2 dane.csv)

