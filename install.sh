#!/bin/sh
#----------------------------------------------------------------------------
# gtest, which is used for C++ code
gtestversion=1.5.0
wget http://googletest.googlecode.com/files/gtest-$gtestversion.tar.gz
rm -rf gtest-$gtestversion
tar -xvzf gtest-$gtestversion.tar.gz
rm gtest-$gtestversion.tar.gz
cd gtest-$gtestversion
./configure
make
sudo make install
# Need to add /usr/local/lib to the ld configuration. For more info:
# http://groups.google.com/group/googletestframework/browse_thread/thread/871aeeca486073b3
sudo bash -c 'echo /usr/local/lib >> /etc/ld.so.conf ' &&  sudo ldconfig

cd ../
rm -rf gtest-$gtestversion

#----------------------------------------------------------------------------
# for compiling objective c
sudo apt-get install gobjc
