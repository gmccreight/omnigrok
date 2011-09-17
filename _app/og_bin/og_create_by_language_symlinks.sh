#!/bin/bash

#create and populate the by_language folder with symlinks to the actual working code

rm -rf by_language

find . -maxdepth 1 \( -name .git -o -name _app -o -name unfinished -o -name by_language \) -prune -o -type d -print | while read dir
do
  if [ $dir != "." ] ; then
    find $dir -mindepth 2 -maxdepth 2 -type d | while read fulldir
    do
      lang=$(echo $fulldir | egrep -o "_[a-z]+$" | egrep -o "[a-z]+")
      mkdir -p by_language/$lang
      ln -s ../../$fulldir by_language/$lang/$(basename $fulldir)
    done
  fi
done
