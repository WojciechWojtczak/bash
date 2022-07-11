#!/bin/bash
#napisz program ktry znajdzie wszystkie pliki *.sh w biezacym katalogu, lub wsrod plikow lub katalogow
# podanych jako parametry, ktore albo nie zawieraja odpowiedniego she-banga w pierszej linijce, lub nie sa
# oznaczone jako pliki wykonywalne
if [ -z $@ ]; then
	find -name '*sh' -type f ! -executable 
else
	for lok in $@; do
		cd $lok
		find -name '*.sh' -type f ! -executable
	done
fi
