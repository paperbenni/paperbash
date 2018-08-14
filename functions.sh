#!/bin/bash

PAPERBASHDIR="$HOME/.config/paperbash"

function pb() {
	case $1 in
	install)
		pushd ~/.paperbash
		echo "searching package sources for $2"
		for PAPERBASHFILE in $HOME/.config/paperbash/sources/*/*/*.paperbash; do #iterate through all name/repo paperbash files
			if grep -q "$2/" "$PAPERBASHFILE"; then
				GITPATH=$(realpath --relative-to="$PAPERBASHDIR/sources" "$PAPERBASHFILE")
				GITREPO=${GITPATH%/packages.paperbash}
				echo "found in $GITREPO"
				echo true >.bashfound
				mkdir -p "$GITREPO/$2"
				echo "created package folder"
				cd "$GITREPO"

				while IFS= read line; do #iterate through lines in PAPERBASHFILE
					if [[ "$line" =~ $2/* ]]; then
						curl --create-dirs -o "$line" https://raw.githubusercontent.com/$GITREPO/master/"$line"
					fi
				done <"$PAPERBASHFILE"
			else
				echo "checked $PAPERBASHFILE"
			fi

			if [ -e ../bashfound ]; then
				echo "done installing $2"
				rm .bashfound
			else
				echo "$2 not found"
			fi

		done

		popd
		;;

	remove)
		echo "uninstalling $2"
		cd ~/.paperbash
		rm -rf "$2"
		echo "successfully uninstalled $2"
	;;

	update)

		#download .paperbash files from sources.txt
		pushd ~/.config/paperbash/sources
		sourcefile="../sources.txt"
		while IFS= read line; do
			echo "updating sources for $line"
			mkdir -p $line
			cd $line
			curl https://raw.githubusercontent.com/"$line"/master/packages.paperbash >packages.paperbash
			cd ~/.config/paperbash/sources
			echo "updated sources for $line"
		done <"$sourcefile"
		popd

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

	rmsource)
		sed -i "/$2/d" "$PAPERBASHDIR"/sources.txt
		echo "removed source $2"
		;;

	upgrade)
		echo "upgrading functions" #weiter
		curl https://raw.githubusercontent.com/paperbenni/paperbash/master/functions.sh >~/.config/paperbash/functions.sh
		;;
	help)
		echo "usage: pb [
			install
			sources
			help
			upgrade
			addsource
			rmsource
			uodate
			]"
		;;
	debug)
		if [ ! -n "$2" ]
		then
			echo "usage: pb debug [ on or off ]"
			exit
		fi
		if [ "$2" -eq "on" ] || [ "$2" -eq "enable" ]
		then
			echo "true" > ~/.config/paperbash/.paperdebug
			echo "debugging mode for paperbash enabled"
		else

			if [ -e ~/.config/paperbash/.paperdebug ]
			then
				rm ~/.config/paperbash/.paperdebug
				echo "debugging mode for paperbash disabled"
			else
				echo "debugging mode already disabled"
			fi
		fi

		;;
	reset)
		pushd ~/
		if curl "https://gist.githubusercontent.com/marioBonales/1637696/raw/337f7b60d4e3d9e887a0206dec6a737e94cdd26e/.bashrc" > .paperbashrc
		then
			echo "beginning reset"
		else
			echo "download failed"
			exit
		fi
		rm -rf .config/paperbash
		rm -rf .paperbash
		rm .bashrc
		mv .paperbashrc .bashrc
		curl "https://raw.githubusercontent.com/paperbenni/paperbash/master/install.sh" | bash

		popd
		;;
	*)
		echo "paperbash Command not found"
		;;
	esac
}
