#!/bin/sh

mode=$1

if [ `echo $mode | egrep "^(all|copy_install_and_test)$" | wc -l`  -eq 0 ] ; then
  echo "error: not a good mode.  Must be 'all' or 'copy_install_and_test'"
  exit
fi

if [ `echo $mode | egrep "^all$" | wc -l`  -eq 0 ] ; then
  ./provisionator.sh rosetta_cs 0-50
fi

if [ `echo $mode | egrep "^copy_install_and_test$" | wc -l`  -eq 0 ] ; then
  ./provisionator.sh rosetta_cs 11,30-50
fi
