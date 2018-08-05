#!/bin/bash

pb(){
    
    pushd ~/.paperbenni
    case $1 in
      install)
        if curl https://raw.githubusercontent.com/paperbenni/bash/master/"$2"/packages.paperbash
        then
          echo "package found"
        else
          echo "package $2 not found!"
          exit
        fi
     
        if [ -e ./"$2" ]
        then
          echo "package $2 already installed"
          exit
        else
          mkdir "$2"
        fi
        cd "$2"

        for PAPERBASHFILE in ./*.paperbash
        do
        while IFS= read line
        do
          if [[ $line = *"$2"* ]]
          then
            echo $line >> "$2".paperbash
          fi
        done <"$PAPERBASHFILE"

        done
        
        file="./$2.paperbash"
        while IFS= read line
        do
          # display $line or do somthing with $line
	        echo "$line"
          PBDIR=${line%/*}
          if [[ $line = *"/"* ]] && [ ! -e $PBDIR ]
          then
            mkdir -p $PBDIR
          fi
          curl -o "$line" https://raw.githubusercontent.com/paperbenni/bash/master/"$line"
        
        done <"$file"

      ;;

      update)
        
        sourcefile="./.sources"
        while IFS= read line
        do
          echo "updating sources for $line"
          curl https://raw.githubusercontent.com/"$line"/master/packages.paperbash > "$line".paperbash

        done <"$sourcefile"



      ;;
      *)
          echo "Command not found"
      ;;
esac
popd
}
