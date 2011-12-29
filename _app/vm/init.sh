#!/bin/sh

# ./init.sh /path/to/pre-existing/iso/file (optional)

#Create a box using veewee

ruby_version="1.9.2-p180"
veewee_version="0.2.2"
veewee_template_name="ubuntu-11.10-server-i386"
boxname="oneiric32"

if [ -d ./veewee ]; then
  echo The ./veewee directory is already created.  Please remove it and try again.
  exit 1
fi

if [ $1 ]; then
  if [ ! -f $1 ]; then
    echo You specified a .iso file as an argument, but it does not exist
    exit 1
  fi
fi

#Install veewee in its own gemset
mkdir veewee
cd veewee
rvm $ruby_version
rvm gemset create veewee
rvm $ruby_version@veewee
gem install veewee -v=$veewee_version --no-ri --no-rdoc

#Create the new basebox, using a local iso file if it specified and exists
vagrant basebox define $boxname $veewee_template_name
#if the iso is provided, then soft link it and use it
if [ $1 ]; then
  mkdir ./iso
  cd ./iso
  ln -s $1 $(basename $1)
  cd ..
fi
vagrant basebox build $boxname
vagrant basebox validate $boxname
vagrant basebox export $boxname
vagrant box add $boxname $boxname.box
rm $boxname.box
