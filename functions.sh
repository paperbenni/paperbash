#!/bin/bash

PAPERBASHDIR="$HOME/.config/paperbash"

function pb() {
	pushd ~/.paperbash >/dev/null
	case $1 in
	install)
		echo "searching package sources for $2"
		for PAPERBASHFILE in ../.config/paperbash/sources/*/*/*.paperbash; do #iterate through all name/repo paperbash files
			if grep -q "$2/" "$PAPERBASHFILE"; then
				echo "found in $PAPERBASHFILE"

				GITREPO=$(realpath --relative-to="$PAPERBASHDIR/sources" "$PAPERBASHFILE")
				mkdir -p "$GITREPO/$2"
				cd "$GITREPO/$2"
				while IFS= read line; do #iterate through lines in PAPERBASHFILE

					if [[ "$line" =~ $2/* ]]; then

						CLEANLINE=${line#$2/} #line without package name

						if [[ "$CLEANLINE" =~ */* ]]; then
							PBDIR=${CLEANLINE%/*}
							echo "created dir for $PBDIR"
							mkdir -p $PBDIR
						fi
						curl -o "$line" https://raw.githubusercontent.com/$GITREPO/master/"$line"
					fi
				done <"$PAPERBASHFILE"
			else
				echo "checked $PAPERBASHFILE"
			fi

		done

		echo "done installing $2"
		;;

	update)

		#download .paperbash files from sources.txt
		cd ~/.config/paperbash/sources
		sourcefile="../sources.txt"
		while IFS= read line; do
			echo "updating sources for $line"
			mkdir -p $line
			cd $line
			curl https://raw.githubusercontent.com/"$line"/master/packages.paperbash >packages.paperbash
			cd ~/.config/paperbash/sources
			echo "updated sources for $line"
		done <"$sourcefile"

		;;

	sources)
		echo "editing source file"
		if nvim -v >/dev/null; then
			nvim ~/.config/paperbash/sources.txt
		else
			touch ~/.config/paperbash/sources.txt
			gedit ~/.config/paperbash/sources.txt
		fi

		;;
	addsource)
		if grep -q "$2" "$PAPERBASHDIR/sources.txt"; then
			echo "source already installed"
		else
			echo "$2" >>$PAPERBASHDIR/sources.txt
			echo "installed source $2" #weiter
		fi
		;;

	upgrade)
		echo "upgrading functions" #weiter
		curl https://raw.githubusercontent.com/paperbenni/paperbash/master/functions.sh >~/.config/paperbash/functions.sh

		;;
	*)
		echo "Command not found"
		;;
	esac
	popd >/dev/null
}
