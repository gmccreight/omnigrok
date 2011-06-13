#!/bin/sh

#----------------------------------------------------------------------------
# [id:buildessential]
# [prereqs:]
# First, ensure that make is installed, since it's used to build lots of the
# other stuff in here.

sudo apt-get install build-essential -y

#----------------------------------------------------------------------------
# [id:git]
# [prereqs:buildessential]
# git is a prerequisite of npm installation

sudo apt-get install git-core -y

#----------------------------------------------------------------------------
# [id:gtest]
# [prereqs:]
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
# [id:objectivec]
# [prereqs:]
# for compiling objective c

sudo apt-get install gobjc -y

#----------------------------------------------------------------------------
# [id:ruby]
# [prereqs:]
# Ruby

sudo apt-get install ruby -y

#----------------------------------------------------------------------------
# [id:java]
# [prereqs:]
# Java, which is used for Java, but also by Rhino for the javascript stuff,
# until we can move things over to node.

sudo apt-get install openjdk-6-jre -y

#----------------------------------------------------------------------------
# [id:libssldev]
# [prereqs:]

sudo apt-get install libssl-dev -y

#----------------------------------------------------------------------------
# [id:nodejs]
# [prereqs:libssldev]

nodeversion=0.4.8
wget http://nodejs.org/dist/node-v$nodeversion.tar.gz
rm -rf node-v$nodeversion
tar -xvzf node-v$nodeversion.tar.gz
rm node-v$nodeversion.tar.gz
cd node-v$nodeversion
./configure
make
sudo make install
cd ..
rm -r node-v$nodeversion

#----------------------------------------------------------------------------
# [id:npm]
# [prereqs:git,nodejs]

git clone http://github.com/isaacs/npm.git
cd npm
sudo make install
cd ..
rm -rf npm

#----------------------------------------------------------------------------
# [id:coffeescript]
# [prereqs:nodejs,npm]
# Coffeescript

sudo npm install -g coffee-script
