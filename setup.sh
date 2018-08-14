#!/bin/bash
pushd ~/ > /dev/null
cd .config/paperbash || (mkdir -p .config/paperbash && cd .config/paperbash)

source functions.sh || (curl -o functions.sh "https://raw.githubusercontent.com/paperbenni/paperbash/master/functions.sh" && source functions.sh)

cd ../../.paperbash || echo "paperbash is not correctly installed"
for FILE in $(find . -name '*.sh'); do
	if [ -e .paperdebug ]; then
		echo "$FILE"
	fi
	source "$FILE"
done
popd > /dev/null
