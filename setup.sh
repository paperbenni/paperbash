#!/bin/bash
if curl --version; then
	echo "curl found"
else
	echo "install curl first"
	exit
fi

echo "going to home dir"
pushd ~/
mkdir .config/ || echo "config found"
cd .config

if git --version; then
	echo "installing git"
	curl https://raw.githubusercontent.com/paperbenni/paperbash/master/functions/pkginstall.sh >pkginstall.sh
	bash pkginstall.sh git
else
	echo "git found"
fi

git clone --depth=1 https://github.com/paperbenni/paperbash.git
cd "paperbash/functions"
chmod +x *.sh
cd ..

RAWGITHUB="https://raw.githubusercontent.com/paperbenni/paperbash/master"

functions/pkginstall.sh git wget

cd ~/

#add paperbash to .bashrc
if (grep 'source ~/.config/paperbash/paperbash.sh || echo paperbash corrupted' ~/.bashrc); then
	echo 'bashrc is already setup'
else
	echo 'source ~/.config/paperbash/paperbash.sh || echo paperbash corrupted' >>~/.bashrc
fi

#setup package diretory
mkdir .paperbash
mkdir .config/papersources || (echo "reinstalling sources" && rm -rf .config/papersources/*)
cd .config/papersources

if [ -e sources.txt ]; then
	echo "leaving existing sources"
else
	echo "paperbenni/bash" >>sources.txt
fi

mkdir sources
popd