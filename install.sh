#!/bin/bash


	PAPERPACKAGES=$(curl https://raw.githubusercontent.com/paperbenni/paperbash/master/required.txt)

if apt -v > /dev/null
then

	sudo apt update -y
	echo "looking for required packages"
	for PACKAGE in $PAPERPACKAGES
	do
		if dpkg -s "$PACKAGE"
		then
			echo "found $PACKAGE"
		else
			echo "$PACKAGE not found, installing"
			sudo apt install -y "$PACKAGE"
		fi

	done
fi

if apk > /dev/null
then
	apk update
	for PACKAGE in $PAPERPACKAGES
	do
		apk install "$PACKAGE"
	done
fi

if ! (apt v- > /dev/null && apk > /dev/null)
then
	echo "the package manager of your os is currently not supported,
	please install the following packages manually
	$PAPERPACKAGES"
fi

pushd ~/
echo "sucessfully installed paperbash"
curl https://raw.githubusercontent.com/paperbenni/paperbash/master/setup.sh >>~/.bashrc
mkdir .paperbash
mkdir .config/paperbash
cd .config/paperbash
curl https://raw.githubusercontent.com/paperbenni/paperbash/master/version.txt >version.txt
curl https://raw.githubusercontent.com/paperbenni/paperbash/master/functions.sh >functions.sh
if [ -e sources.txt ]; then
	echo "leaving existing sources"
else
	echo "paperbenni/bash" >>sources.txt
fi
mkdir sources
popd
