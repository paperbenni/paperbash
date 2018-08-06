#!/bin/bash
pushd ~/
  echo "sucessfully installed paperbash"
  curl https://raw.githubusercontent.com/paperbenni/paperbash/master/setup.sh >> ~/.bashrc
  mkdir .paperbash
  mkdir .config/paperbash
  cd .config/paperbash
  curl https://raw.githubusercontent.com/paperbenni/paperbash/master/version.txt > version.txt
  curl https://raw.githubusercontent.com/paperbenni/paperbash/master/functions.sh > functions.sh
  echo paperbash/bash >> sources.txt
popd