#!/bin/bash
#download .paperbash files from sources.txt
source ~/.config/paperbash/veriables.sh

pushd ~/.config/paperbash/sources
sourcefile="../sources.txt"
while IFS= read line; do
	echo "updating sources for $line"
	mkdir -p $line
	cd $line
	curl "$RAWGITHUB/$line/master/packages.paperbash >packages.paperbash"
	cd ~/.config/paperbash/sources
	echo "updated sources for $line"
done <"$sourcefile"
popd
