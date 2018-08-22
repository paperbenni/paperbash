#!/bin/bash
if [ -n "$1" ]; then
	echo "upgrading $1"
    pushd ~/.paperbash
    for DIR in ./*/*
    do
        if [ $DIR = "$1" ]
        then
            echo "upgrading $1"
        fi
    done
else
	source ~/.config/paperbash/veriables.sh
	echo "upgrading functions" #weiter
	cd .config/paperbash
	git pull --depth=1
fi
