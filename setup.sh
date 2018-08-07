#!/bin/bash
pushd ~/
cd .config/paperbash
source functions.sh

cd ../../.paperbash
for FILE in $(find . -name '*.sh'); do
	if [ -e .paperdebug ]; then
		echo "$FILE"
	fi
	source "$FILE"
done
popd