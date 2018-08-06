#!/bin/bash
pushd ~/
cd .config/paperbash
source functions.sh
cd ../../.paperbash
for FILE in $(find . -name '*.sh'); do
	[ -e $FILE ] || continue
	source $FILE
done
popd