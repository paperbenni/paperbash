#!/bin/bash

if [ ! -n "$1" ]
then
	echo "usage: pb install [package-name]"
	exit 0
fi

pushd ~/.paperbash

while read -r p; do
	echo "$p"
	if ! git ls-remote https://github.com/"$p".git -q; then
		echo "$p is an invalid repo"
		exit 1
	fi

	svn export https://github.com/"$p"/trunk/"$1" "$HOME"/.cache/paperbash
	cd "$HOME"/.cache/paperbash/"$1" || exit
	mv run ~/paperbin
	mv start ~/paperstart

	for PAPER in ./*.paperpackage; do
		case "$PAPER" in
		gem.paperpackage)
			~/.config/paperbash/functions/pkginstall.sh ruby-full
			PACKAGELIST=$(cat "$CHECKFILE")
			for PACKAGE in $PACKAGELIST; do
				if gem -v >/dev/null; then
					sudo gem install "$PACKAGE"
				fi
			done
			;;
		trigger.paperpackage)
			source "$PAPER"
			;;
		install.paperpackage)
			"$HOME"/.config/paperbash/functions/pkginstall.sh "$(cat "$PAPER")"
			;;
		npm.paperpackage)
			~/.config/paperbash/functions/pkginstall.sh nodejs
			~/.config/paperbash/functions/pkginstall.sh npm
			PACKAGELIST=$(cat "$PAPER")
			for PACKAGE in $PACKAGELIST; do
				if npm -v >/dev/null; then
					sudo npm install -g "$PACKAGE"
				fi

			done
			;;
		pip3.paperpackage)
			~/.config/paperbash/functions/pkginstall.sh python-pip python-dev build-essential
			PACKAGELIST=$(cat "$PAPER")
			for PACKAGE in $PACKAGELIST; do

				if pip --version; then
					pip3 install --user "$PACKAGE"
				fi
			done
			;;

		esac
	done

done \
	<~/.config/paperbash/sources.txt

popd
