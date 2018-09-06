#!/bin/bash
pushd ~/.paperbash
RAWGIT="https://raw.githubusercontent.com"

echo "searching package sources for $1"
#delete .bashfound if existing
cat .bashfound >/dev/null && rm .bashfound

#iterate through all name/repo paperbash files
for PAPERBASHFILE in $HOME/.config/papersources/*/*/*.paperbash; do
	if grep -q "$1/" "$PAPERBASHFILE"; then
		GITPATH=$(realpath --relative-to="$PAPERBASHDIR/sources" "$PAPERBASHFILE")
		GITREPO=${GITPATH%/packages.paperbash}
		echo "found in $GITREPO"
		echo true >~/.paperbash/.bashfound
		mkdir -p "$GITREPO/$1"
		echo "created package folder"
		pushd "$GITREPO"

		#iterate through lines in PAPERBASHFILE
		while IFS= read line; do
			if [[ "$line" =~ $1/* ]]; then
				if [[ "$line" == $1/*paperref ]]; then
					FILEURL=$(curl "$RAWGIT/$GITREPO/master/$line")

					REALFILENAME=${line%.paperref}
					curl --create-dirs -o "$REALFILENAME" "$FILEURL"
				else
					curl --create-dirs -o "$line" "$RAWGIT/$GITREPO/master/$line"
				fi

			fi

		done <"$PAPERBASHFILE"
	else
		echo "checked $PAPERBASHFILE"
	fi

	for CHECKFILE in $(find .); do
		case "$CHECKFILE" in
		*.paperinstall)
			bash "$CHECKFILE"
			;;
		*/apk.paperpackage)
			PACKAGELIST=$(cat "$CHECKFILE")
			for PACKAGE in $PACKAGELIST; do
				if apk -v >/dev/null; then
					sudo apk update
					sudo apk add "$PACKAGE"
				fi

			done
			;;
		*/gem.paperpackage)
			~/.config/paperbash/functions/pkginstall.sh ruby-full
			PACKAGELIST=$(cat "$CHECKFILE")
			for PACKAGE in $PACKAGELIST; do
				if gem -v >/dev/null; then
					sudo gem install "$PACKAGE"
				fi
			done
			;;
		*/apt.paperpackage)
			PACKAGELIST=$(cat "$CHECKFILE")
			for PACKAGE in $PACKAGELIST; do
				if apk -v >/dev/null; then
					sudo apt-get update
					sudo apt-get install -y "$PACKAGE"
				fi

			done
			;;
		*/npm.paperpackage)
			~/.config/paperbash/functions/pkginstall.sh nodejs
			~/.config/paperbash/functions/pkginstall.sh npm
			PACKAGELIST=$(cat "$CHECKFILE")
			for PACKAGE in $PACKAGELIST; do
				if npm -v >/dev/null; then
					sudo npm install -g "$PACKAGE"
				fi

			done
			;;

		esac

	done

	popd
	#try installing package with normal package manager
	if [ -e ~/.paperbash/.bashfound ]; then
		echo "done installing $1"
		rm ~/.paperbash/.bashfound
	else
		echo "$1 not found"
		if apt show "$1"; then
			echo "trying apt"
			sudo apt update
			sudo apt install -y "$1"
		fi
	fi

done

popd
