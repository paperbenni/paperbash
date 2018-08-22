#!/bin/bash
if [ -n "$1" ]
then
	if [ -e ~/.paperbash/*/"$1"/help.txt ]
	then
		cat help.txt | less
	else
		echo "package not found"
	fi
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
