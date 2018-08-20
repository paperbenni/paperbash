#!/bin/bash

PAPERBASHDIR="$HOME/.config/paperbash"
PAPERGITHUB="https://raw.githubusercontent.com/paperbenni/paperbash/master"
RAWGITHUB="https://raw.githubusercontent.com"
EDITOR=nvim

function pb() {
	case $1 in
	install)
		$PAPERBASHDIR/functions/install.sh "$2" || (curl "$PAPERGITHUB/functions/install.sh" > $PAPERBASHDIR/functions/install.sh && $PAPERBASHDIR/functions/install.sh "$2")
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
			curl "$RAWGITHUB/$line/master/packages.paperbash >packages.paperbash"
			cd ~/.config/paperbash/sources
			echo "updated sources for $line"
		done <"$sourcefile"
		popd

		;;

	disable)

		for DIR in ~/.paperbash/*/*
		do
			if [ $DIR = "$2" ]
			then
				for SHFILE in $(find "$DIR")
				do
					if [ $SHFILE = "*.sh" ]
					then
						mv "$SHFILE" "$SHFILE.paperdisable"
					fi
				done
			fi
		done
		echo "disabled $2 please restart bash for the changes to apply"

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
		curl "$PAPERGITHUB/functions.sh" >~/.config/paperbash/functions.sh
		curl "$PAPERGITHUB/functions/install.sh" >~/.config/paperbash/functions/install.sh
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
		if [ "$2" = "on" ] || [ "$2" = "enable" ]
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
		curl "$PAPERGITHUB/master/install.sh" | bash

		popd
		;;
	*)
		echo "paperbash Command not found"
		;;
	esac
}
