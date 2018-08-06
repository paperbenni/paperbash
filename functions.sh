#!/bin/bash

pb(){
  pushd ~/.paperbenni
  case $1 in
    install)
      #check if package is already installed

      #generate file list for package from package sources 
      for PAPERBASHFILE in ../.config/paperbash/sources/*/*.paperbash #iterate through all name/repo paperbash files
      do
      while IFS= read line
        do
          if [[ $line = *"$2/"* ]]
          then
            echo $line >> "$2".paperbash
          fi
        done <"$PAPERBASHFILE"

        done

        #download files from generated .paperbash file        
        file="./$2.paperbash"
        while IFS= read line
        do
	        echo "$line"
          if [[ $line = *"/"* ]] && [ ! -e $PBDIR ]
          then
            PBDIR=${line%/*}
            mkdir -p $PBDIR
          fi
          curl -o "$line" https://raw.githubusercontent.com/paperbenni/bash/master/"$line"
        
        done <"$file"

        rm "$2".paperbash
        echo "done installing $2"
      ;;

      update)


        #download .paperbash files from sources.txt
        cd ~/.config/paperbash/sources
        sourcefile="../sources.txt"
        while IFS= read line
        do
          echo "updating sources for $line"
          GITHUBNAME=${$line%/*}
          mkdir $GITHUBNAME
          curl https://raw.githubusercontent.com/"$line"/master/packages.paperbash > "$line".paperbash

        done <"$sourcefile"



      ;;
      sources)
      if nvim -v
      then
        nvim .config/paperbash/sources.txt
      else
        gedit .config/paperbash/sources.txt
      fi

      ;;

      *)
          echo "Command not found"
      ;;
esac
popd
}
