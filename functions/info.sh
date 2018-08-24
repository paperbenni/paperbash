#!/bin/bash
source ~/.config/paperbash/veriables.sh
if [ ! -n "$1" ]; then
	echo "usage: pb info [package] [property]"
	exit
fi
if [ ! -n "$2" ]; then
	for INFOFILE in ~/.paperbash/*/"$1"/.paperinfo; do
		cat "$INFOFILE"
	done
fi

for INFOFILE in ~/.paperbash/*/"$1"/.paperinfo; do
	FILEINFO=$(grep "$1" "$INFOFILE")
	ECHOINFO=${FILEINFO##": "}
	echo "$ECHOINFO"
done
