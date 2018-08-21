#!/bin/bash

RAWGITHUB="https://raw.githubusercontent.com/paperbenni/paperbash/master"

PAPERPACKAGES=$(curl "$RAWGITHUB/required.txt")


function gitget(){
	curl -o "$1" "$RAWGITHUB/$1"
}

if apt -v >/dev/null; then

	sudo apt update -y
	echo "looking for required packages"
	for PACKAGE in $PAPERPACKAGES; do
		if dpkg -s "$PACKAGE"; then
			echo "found $PACKAGE"
		else
			echo "$PACKAGE not found, installing"
			sudo apt install -y "$PACKAGE"
		fi

	done
fi

if apk >/dev/null; then
	apk update
	for PACKAGE in $PAPERPACKAGES; do
		apk install "$PACKAGE"
	done
fi

if ! (apt v- >/dev/null && apk >/dev/null); then
	echo "the package manager of your os is currently not supported,
	please install the following packages manually
	$PAPERPACKAGES"
fi

pushd ~/
echo "sucessfully installed paperbash"
if (grep 'source ~/.config/paperbash/setup.sh || echo paperbash corrupted' ~/.bashrc); then
	echo 'bashrc is already setup'
else
	echo 'source ~/.config/paperbash/setup.sh || echo paperbash corrupted' >>~/.bashrc
fi
mkdir .paperbash
mkdir .config/paperbash
cd .config/paperbash
gitget "version.txt"
gitget "functions.sh"
gitget "setup.sh"
mkdir functions
gitget "functions/install.sh"
gitget "functions/pkginstall.sh"

if [ -e sources.txt ]; then
	echo "leaving existing sources"
else
	echo "paperbenni/bash" >>sources.txt
fi
mkdir sources
popd
