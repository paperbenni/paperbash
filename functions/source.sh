#!/bin/bash
if ! [ -n "$1" ]; then
	echo " usage: pb source [edit, add, remove]"
	exit
fi


case "$1" in
edit)
	echo "editing source file"
	if nvim -v >/dev/null; then
		nvim ~/.config/paperbash/sources.txt
	else
		touch ~/.config/paperbash/sources.txt
		gedit ~/.config/paperbash/sources.txt
	fi

	;;
add)
	if grep -q "$2" "$PAPERBASHDIR/sources.txt"; then
		echo "source already installed"
	else
		echo "$2" >>$PAPERBASHDIR/sources.txt
		echo "installed source $2" #weiter
	fi
	;;

remove)
	sed -i "/$2/d" "$PAPERBASHDIR"/sources.txt
	echo "removed source $2"
	;;
esac
