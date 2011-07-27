#!/bin/sh

mode=$1

if [ `echo $mode | egrep "^(all|run_copy_install_and_test|copy_install_and_test)$" | wc -l`  -eq 0 ] ; then
  echo "error: not a good mode.  Must be 'all', 'run_copy_install_and_test', or 'copy_install_and_test'"
  exit
fi

if [ `echo $mode | egrep "^all$" | wc -l`  -eq 1 ] ; then
  ./provisionator.sh omnigrok 0-50
fi

if [ `echo $mode | egrep "^run_copy_install_and_test$" | wc -l`  -eq 1 ] ; then
  ./provisionator.sh omnigrok 11,30-50
fi

if [ `echo $mode | egrep "^copy_install_and_test$" | wc -l`  -eq 1 ] ; then
  ./provisionator.sh omnigrok 30-50
fi
