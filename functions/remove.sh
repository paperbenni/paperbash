#!/bin/bash
echo "uninstalling $2"
cd ~/.paperbash || echo "paperbash broken"
if [ -e ./"$1" ]
then
	cd "$1"
	if [ -e .paperdisable ]
	then
		bash .paperdisable
	fi
	rm -rf "$2"
	echo "successfully uninstalled $2"
else
	echo "package not found"
fi
