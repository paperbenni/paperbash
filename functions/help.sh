#!/bin/bash
if [ -n "$1" ]; then
	for helpfile in ~/.paperbash/*/"$1"/help.txt; do
		if [ -e "$helpfile" ]; then
			less < "$helpfile"
		else
			echo "package not found"
		fi

	done

else
	echo "usage: pb [
		install
		sources
		help
		upgrade
		addsource
		rmsource
		update
		]"
fi
