#!/bin/bash

#Run all the directories and see if there are any issues

cd ../

find . -maxdepth 1 \( -name .git -o -name _app -o -name unfinished -o -name languages \) -prune -o -type d -print | while read dir
do
  if [ $dir != "." ] ; then
    find $dir -mindepth 2 -maxdepth 2 -type d | while read fulldir
    do
      lang=$(echo $fulldir | egrep -o "_[a-z]+$" | egrep -o "[a-z]+")
      mkdir -p languages/$lang
      ln -s ../../$fulldir languages/$lang/$(basename $fulldir)
    done
  fi
done

cd _app
