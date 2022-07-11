#!/bin/bash
#uczyn program z zadania 11 konfigurowalnym za pomoca opcji -d <separator_dziesietny> -t <separator_tysieczny>
sepd=""
sept=""
usage() {
  echo "Usage: $0 [ -d <separator_dziesietny> ] [ -t <separator_tysieczny> ]" 1>&2 
}
exit_abnormal() {
  usage
  exit 1
}
while getopts ":d:t:" options; do
	case "${options}" in
	 d)
	  sepd=${OPTARG}
	  ;;
	 t)
	  sept=${OPTARG}
	  ;;
	 :)
	  echo "Error: -${optarg} potrzebuje argumentu"
	  exit_abnormal
	  ;;
	 *)
	  exit_abnormal
	  ;;
	esac
done
echo "Podaj liczbe"
read int
if grep -q "," <<< $int; then
	tys=$(echo $int | sed 's/,.*//g')
	dzie=$(echo $int | sed 's/^.*,//g')
	tys=$(echo $tys | sed ':a;s/\B[0-9]\{3\}\>/,&/;ta')
	tys=$(echo $tys | sed "s/,/$sept/g")
	echo "$tys$sepd$dzie"
elif grep -q "\." <<< $int; then
	tys=$(echo $int | sed 's/\..*//g')
        dzie=$(echo $int | sed 's/^.*\.//g')
        tys=$(echo $tys | sed ':a;s/\B[0-9]\{3\}\>/,&/;ta')
	tys=$(echo $tys | sed "s/,/$sept/g")
        echo "$tys$sepd$dzie"
else
	echo $int | sed ':a;s/\B[0-9]\{3\}\>/,&/;ta'
fi
