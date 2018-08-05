#!/bin/bash
pushd ~/
install(){
  echo "sucessfully installed paperbash"
  curl https://raw.githubusercontent.com/paperbenni/bash/master/setup.sh >> ~/.bashrc
  cd .paperbenni
  curl https://raw.githubusercontent.com/paperbenni/bash/master/version.txt > version.txt
  echo "paperbenni/bash" >> .sources
}

if grep -q "paperbennibash01" ~/.bashrc
then
  echo "already installed"
else
  install
fi
popd