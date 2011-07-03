#!/bin/bash

#Run all the directories and see if there are any issues

cd ../../
find . -maxdepth 1 \( -name .git -o -name _app -o -name sandbox \) -prune -o -type d -print | while read dir
do
  if [ $dir != "." ] ; then
    find $dir -mindepth 1 -maxdepth 1 -type d | while read fulldir
    do
      ./_app/runner.rb do_all_tests_pass $fulldir
    done
  fi
done
cd _app/tests