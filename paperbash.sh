#!/bin/bash
pushd ~/ >/dev/null
cd .config/paperbash || (mkdir -p .config/paperbash && cd .config/paperbash)

source functions.sh 2>/dev/null || (curl -o functions.sh "https://raw.githubusercontent.com/paperbenni/paperbash/master/functions.sh" && source functions.sh)

cd paperstart
for FILE in ./*; do
	source "$FILE"
	if [ -e "$HOME"/.paperdebug ]; then
		echo "$FILE"
	fi
done

export PATH=$PATH:$HOME/paperbin

popd >/dev/null
