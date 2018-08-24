#!/bin/bash

pushd ~
mkdir .config/paperbash
cd .config/paperbash

git clone --depth=1 https://github.com/paperbenni/paperbash.git .
cd "functions"
chmod +x *.sh
cd ..

RAWGITHUB="https://raw.githubusercontent.com/paperbenni/paperbash/master"

if apt -v >/dev/null; then
	sudo apt update -y
	sudo apt install -y git wget

fi

if apk >/dev/null; then
	sudo apk update
	sudo apk add git wget
fi

if ! (apt v- >/dev/null && apk >/dev/null); then
	echo "the package manager of your os is currently not supported,
	please install the following packages manually: 
	git"
fi

cd ~/

#add paperbash to .bashrc
if (grep 'source ~/.config/paperbash/paperbash.sh || echo paperbash corrupted' ~/.bashrc); then
	echo 'bashrc is already setup'
else
	echo 'source ~/.config/paperbash/paperbash.sh || echo paperbash corrupted' >>~/.bashrc
fi

#setup package diretory
mkdir .paperbash
mkdir .config/papersources
cd .config/papersources

if [ -e sources.txt ]; then
	echo "leaving existing sources"
else
	echo "paperbenni/bash" >>sources.txt
fi

mkdir sources
popd
