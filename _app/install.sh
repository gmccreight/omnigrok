#!/bin/sh

force_install=0

should_install () {

  if [ $force_install -eq 1 ]; then
    echo 1 && return
  fi

  if [ `dpkg --get-selections | grep $1 | wc -l` -eq 1 ]; then
    echo 0 && return
  fi

  if [ `which $1 | grep $1 | wc -l` -eq 1 ]; then
    echo 0 && return
  fi

  echo 1 && return

}

apt_get_install () {
  #Only install if not already installed
  if [ $(should_install $1) -eq 1 ]; then
    sudo apt-get install $1 -y
  fi
}

#----------------------------------------------------------------------------
# [id:buildessential]
# [prereqs:]
# First, ensure that make is installed, since it's used to build lots of the
# other stuff in here.

apt_get_install build-essential

#----------------------------------------------------------------------------
# [id:git]
# [prereqs:buildessential]
# git is a prerequisite of npm installation

apt_get_install git-core

#----------------------------------------------------------------------------
# [id:gtest]
# [prereqs:]
# gtest, which is used for C++ code

if [ $(should_install gtest-config) -eq 1 ]; then
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
fi

#----------------------------------------------------------------------------
# [id:objectivec]
# [prereqs:]
# for compiling objective c

apt_get_install gobjc

#----------------------------------------------------------------------------
# [id:ruby]
# [prereqs:]
# Ruby

apt_get_install ruby

#----------------------------------------------------------------------------
# [id:java]
# [prereqs:]
# Java, which is used for Java, but also by Rhino for the javascript stuff,
# until we can move things over to node.

apt_get_install openjdk-6-jre

#----------------------------------------------------------------------------
# [id:libssldev]
# [prereqs:]

apt_get_install libssl-dev

#----------------------------------------------------------------------------
# [id:nodejs]
# [prereqs:libssldev]

if [ $(should_install node) -eq 1 ]; then
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
fi

#----------------------------------------------------------------------------
# [id:npm]
# [prereqs:git,nodejs]

if [ $(should_install npm) -eq 1 ]; then
  git clone http://github.com/isaacs/npm.git
  cd npm
  sudo make install
  cd ..
  sudo rm -rf npm
fi

#----------------------------------------------------------------------------
# [id:coffeescript]
# [prereqs:nodejs,npm]
# Coffeescript

if [ $(should_install coffee) -eq 1 ]; then
  sudo npm install -g coffee-script
fi

#----------------------------------------------------------------------------
# [id:scala]
# [prereqs:java]
# Scala

if [ ! -d local/scala || $force_install -eq 1 ]; then
  wget -O local/scala.tgz http://www.scala-lang.org/downloads/distrib/files/scala-2.9.0.1.tgz
  cd local
  tar -xvzf scala.tgz
  rm scala.tgz
  mv scala-* scala
  cd ..
fi
