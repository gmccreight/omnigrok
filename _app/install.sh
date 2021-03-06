#!/bin/sh

force_install=0

should_install () {

  if [ $force_install -eq 1 ]; then
    echo 1 && return
  fi

  if [ `dpkg --get-selections | egrep "^$1\s+install$" | wc -l` -eq 1 ]; then
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
# [requiredby:*lots*]

apt_get_install build-essential

#----------------------------------------------------------------------------
# [id:unzip]
# [prereqs:]
# [requiredby:clojure]

apt_get_install unzip

#----------------------------------------------------------------------------
# [id:git]
# [prereqs:buildessential]
# [requiredby:npm]

apt_get_install git-core

#----------------------------------------------------------------------------
# [id:gtest]
# [prereqs:unzip]
# [requiredby:]
# gtest, which is used for C++ code

if [ ! -d og_tests/frameworks/cc_gtest-1.6.0 ]; then
  wget -O gtest.zip http://googletest.googlecode.com/files/gtest-1.6.0.zip
  unzip gtest.zip
  mv gtest-* og_tests/frameworks/cc_gtest-1.6.0
  cd og_tests/frameworks/cc_gtest-1.6.0
  ./configure
  make
  g++ -I./include -I. -c ./src/gtest-all.cc
  ar -rv libgtest.a gtest-all.o
  cd ../../..
  rm -rf gtest.zip
fi

#----------------------------------------------------------------------------
# [id:objectivec]
# [prereqs:]
# [requiredby:]
# for compiling objective c

apt_get_install gobjc

#----------------------------------------------------------------------------
# [id:ruby]
# [prereqs:]
# [requiredby:]
# Ruby

apt_get_install ruby

#----------------------------------------------------------------------------
# [id:pyunit]
# [prereqs:]
# [requiredby:]
# Pyunit

apt_get_install python-unit

#----------------------------------------------------------------------------
# [id:java]
# [prereqs:]
# [requiredby:clojure,js,scala]
# Java, which is used for Java, but also by Rhino for the javascript stuff,
# until we can move things over to node.

apt_get_install openjdk-6-jre

#----------------------------------------------------------------------------
# [id:libssldev]
# [prereqs:]
# [requiredby:nodejs]

apt_get_install libssl-dev

#----------------------------------------------------------------------------
# [id:nodejs]
# [prereqs:libssldev]
# [requiredby:npm,coffeescript]

if [ $(should_install node) -eq 1 ]; then
  nodeversion=0.6.6
  wget http://nodejs.org/dist/v$nodeversion/node-v$nodeversion.tar.gz
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
# [requiredby:coffeescript]

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
# [requiredby:]
# Coffeescript

if [ $(should_install coffee) -eq 1 ]; then
  sudo npm install -g coffee-script
fi

#----------------------------------------------------------------------------
# [id:scala]
# [prereqs:java]
# [requiredby:]
# Scala

if [ ! -d local/scala ] || [ $force_install -eq 1 ]; then
  wget -O local/scala.tgz http://www.scala-lang.org/downloads/distrib/files/scala-2.9.0.1.tgz
  cd local
  tar -xvzf scala.tgz
  rm scala.tgz
  mv scala-* scala
  cd ..
fi

#----------------------------------------------------------------------------
# [id:python_development_tools]
# [prereqs:buildessential]
# [requiredby:mercurial]
# Python setup tools

apt_get_install python-setuptools
apt_get_install python-dev

#----------------------------------------------------------------------------
# [id:mercurial]
# [prereqs:buildessential,python_development_tools]
# [requiredby:go]
# mercurial is a prerequisite of go installation

if [ $(should_install hg) -eq 1 ]; then
  sudo easy_install mercurial
fi

#----------------------------------------------------------------------------
# [id:go]
# [prereqs:mercurial]
# [requiredby:]
# Go

if [ ! -d local/go ] || [ $force_install -eq 1 ]; then
  hg clone -u release https://go.googlecode.com/hg/ local/go
  cd local/go/src
  ./all.bash
  cd ../../..
fi

#----------------------------------------------------------------------------
# [id:clojure]
# [prereqs:unzip,java]
# [requiredby:]
# Clojure

if [ ! -d local/clojure ] || [ $force_install -eq 1 ]; then
  cd local
  wget -O clojure.zip https://github.com/downloads/clojure/clojure/clojure-1.2.1.zip
  unzip clojure.zip
  rm clojure.zip
  mv clojure-* clojure
  cd ..
fi

#----------------------------------------------------------------------------
# [id:haskell]
# [prereqs:]
# [requiredby:]
# Haskell

apt_get_install ghc6
apt_get_install libghc6-mtl-dev
apt_get_install libghc6-hunit-dev

#----------------------------------------------------------------------------
# [id:lua]
# [prereqs:]
# [requiredby:]
# Lua

if [ $(should_install lua) -eq 1 ]; then
  wget -O lua.tgz http://www.lua.org/ftp/lua-5.1.4.tar.gz
  tar -xvzf lua.tgz
  cd lua*
  make linux
  sudo make install
  cd ../
  rm -rf lua*
fi

if [ ! -f local/lunit/lunit ]; then
  cd local
  wget -O lunit.tgz http://www.nessie.de/mroth/lunit/lunit-0.5.tar.gz
  tar -xvzf lunit.tgz
  mv lunit-* lunit
  rm lunit.tgz
  cd ..
fi
