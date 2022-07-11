#!/bin/bash
#Zaznacz linijki ktore pasuja do podanego wzorca regularnego, ujmujac je w linijki VVV oraz ^^^
value=$(grep "$1" text.txt)
cat text.txt | sed "s/^.*$value/VVV\n$value\n^^^/g"

