#!/bin/bash
pushd ~/.paperbash
RAWGIT=https://raw.githubusercontent.com
echo "searching package sources for $1"
cat .bashfound > /dev/null && rm .bashfound
for PAPERBASHFILE in $HOME/.config/paperbash/sources/*/*/*.paperbash; do #iterate through all name/repo paperbash files
	if grep -q "$1/" "$PAPERBASHFILE"; then
		GITPATH=$(realpath --relative-to="$PAPERBASHDIR/sources" "$PAPERBASHFILE")
		GITREPO=${GITPATH%/packages.paperbash}
		echo "found in $GITREPO"
		echo true >~/.paperbash/.bashfound
		mkdir -p "$GITREPO/$1"
		echo "created package folder"
		pushd "$GITREPO"

		while IFS= read line; do #iterate through lines in PAPERBASHFILE
			if [[ "$line" =~ $1/* ]]; then
				if [[ "$line" =~ $1/*paperref ]]
				then
					FILEURL=$(curl "$RAWGIT/$GITREPO/master/$line")

					REALFILENAME=${line%.paperref}
					curl --create-dirs -o "$REALFILENAME" "$FILEURL"
				else
					curl --create-dirs -o "$line" $RAWGIT/$GITREPO/master/"$line"

				fi
				if [[ "$line" =~ $1/*paperpackage ]]
				then
					PACKAGELIST=$(curl "$RAWGIT/$GITREPO/master/$line")
					for PACKAGE in $PACKAGELIST
					do
						if apt -v > /dev/null
						then
							sudo apt update
							sudo apt install -y $PACKAGE
							continue
						fi

						if apk -v > /dev/null
						then
							sudo apk update
							sudo apt add $PACKAGE
							continue
						fi

					done
				fi
			fi
		done <"$PAPERBASHFILE"
	else
		echo "checked $PAPERBASHFILE"
	fi
	popd
	if [ -e ~/.paperbash/.bashfound ]; then
		echo "done installing $1"
		rm ~/.paperbash/.bashfound
	else
		echo "$1 not found"
		if apt show "$1"
		then
			echo "trying apt"
			sudo apt update
			sudo apt install -y "$1"
		fi
	fi

done

popd

