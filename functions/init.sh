#!/bin/bash
NAME=$(dialog --inputbox "Enter the package name :" 8 40 2)
mkdir "$NAME"
cd "$NAME" || (echo "please enter a name" && exit 1)
echo "paperpackage: $1" > paperbash.conf
mkdir run
echo '#!/bin/bash' > run/"$1"
mkdir data
mkdir start
echo "created package $1"