#!/bin/bash
pushd ~/
install(){
  echo "sucessfully installed paperbash"
  curl https://raw.githubusercontent.com/paperbenni/paperbash/master/setup.sh >> ~/.bashrc
  mkdir .paperbash
  mkdir .config/paperbash
  cd .config/paperbash
  curl https://raw.githubusercontent.com/paperbenni/paperbash/master/version.txt > version.txt
  curl https://raw.githubusercontent.com/paperbenni/paperbash/master/functions.sh > functions.sh
  echo paperbash/bash >> sources.txt
}
  NEWVERSION=$(curl https://raw.githubusercontent.com/paperbenni/paperbash/master/version.txt)
  OLDVERSIOn=$(cat ~/.config/paperbash/version.txt)
if [ -e ~/.config/paperbash/version.txt ] && [ $NEWVERSION = $OLDVERSION ]
then
  echo "already installed"
else
  install
fi
popd