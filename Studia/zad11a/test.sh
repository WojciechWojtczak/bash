#!/bin/bash
while getopts "[:d:t:]" options; do
	case "${options}" in
		d)
			sepd=${OPTARG}
			;;
		t)
			sept=${OPTARG}
			;;
	esac
done
echo "testowa linka ." | sed "s/\./$sept/g"
