#!/bin/bash
source ~/.config/paperbash/veriables.sh
if [ -n "$1" ]; then
	echo "upgrading $1"
	pushd ~/.paperbash
	echo "upgrading $1"
    #weiter
	$PAPERFUNCTIONS/remove.sh "$1"
	$PAPERFUNCTIONS/install.sh "$1"
else
	echo "upgrading functions"
	cd .config/paperbash
	git pull --depth=1
fi
