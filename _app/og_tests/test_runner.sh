#!/bin/bash

#Run all the directories and see if there are any issues

find . -maxdepth 1 \( -name .git -o -name _app -o -name unfinished \) -prune -o -type d -print | while read dir
do
  if [ $dir != "." ] ; then
    find $dir -mindepth 2 -maxdepth 2 -type d | while read fulldir
    do
      ./_app/og_bin/og_runner.rb do_all_tests_pass $fulldir
    done
  fi
done
