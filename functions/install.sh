#!/bin/bash
pushd ~/.paperbash
echo "searching package sources for $1"
for PAPERBASHFILE in $HOME/.config/paperbash/sources/*/*/*.paperbash; do #iterate through all name/repo paperbash files
	if grep -q "$1/" "$PAPERBASHFILE"; then
		GITPATH=$(realpath --relative-to="$PAPERBASHDIR/sources" "$PAPERBASHFILE")
		GITREPO=${GITPATH%/packages.paperbash}
		echo "found in $GITREPO"
		echo true >.bashfound
		mkdir -p "$GITREPO/$1"
		echo "created package folder"
		pushd "$GITREPO"

		while IFS= read line; do #iterate through lines in PAPERBASHFILE
			if [[ "$line" =~ $1/* ]]; then
				curl --create-dirs -o "$line" https://raw.githubusercontent.com/$GITREPO/master/"$line"
			fi
		done <"$PAPERBASHFILE"
	else
		echo "checked $PAPERBASHFILE"
	fi
	popd
	if [ -e ./bashfound ]; then
		echo "done installing $1"
		rm .bashfound
	else
		echo "$1 not found"
	fi

done

popd

