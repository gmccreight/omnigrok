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

#----------------------------------------------------------------------------
# Java, which is used for Java, but also by Rhino for the javascript stuff,
# until we can move things over to node
sudo apt-get install sun-java6-jdk

#----------------------------------------------------------------------------
# Install node into the ./local directory (within the _app) directory
nodeversion=0.4.7
wget http://nodejs.org/dist/node-v$nodeversion.tar.gz
rm -rf node-v$nodeversion
tar -xvzf node-v$nodeversion.tar.gz
rm node-v$nodeversion.tar.gz
cd node-v$nodeversion
mkdir -p ../local
./configure --prefix=../local/node
make
make install
cd ..
rm -r node-v$nodeversion
