#!/bin/bash

pb(){
  pushd ~/.paperbash
  case $1 in
    install)
      #check if package is already installed

      #generate file list for package from package sources 
      for PAPERBASHFILE in ../.config/paperbash/sources/*/*.paperbash #iterate through all name/repo paperbash files
      do

      while IFS= read line #iterate through lines in PAPERBASHFILE
        do
          if [[ $line = *"$2/"* ]]
          then
          PACKAGEGITPATH=$(realpath --relative-to="~/.paperbash" "$PAPERBASHFILE")
          PACKAGEGITREPO=${PACKAGEGITPATH%.paperbash} #this is the repo name
          mkdir -p "$PACKAGEGITREPO"
          # now in username/repo dir
          cd $PACKAGEGITREPO
          mkdir "$2" #make package name
          CLEANLINE=${line#$2/}
          cd "$2"
          if [[ $CLEANLINE = *"/"* ]] #create directory
          then
            PBDIR=${CLEANLINE%/*}
            if [ -e $PBDIR ]
            then
              mkdir -p $PBDIR
            fi
          fi

          curl -o "$line" https://raw.githubusercontent.com/$PACKAGEGITREPO/master/"$line"
          fi
        done <"$PAPERBASHFILE"

        done

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
