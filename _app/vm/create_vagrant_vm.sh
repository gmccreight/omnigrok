#!/bin/bash

# ./_app/vm/create_vagrant_vm.sh /path/to/pre-existing/iso/file (optional)

#Create a box using veewee

ruby_version="1.9.2"
veewee_version="0.2.2"
veewee_template_name="ubuntu-11.10-server-i386"
boxname="oneiric32"

cd ./_app/vm

if [[ -d ./veewee ]]; then
  echo The ./veewee directory is already created in _app/vm/.  Please remove it and try again.
  cd ../..
  exit 1
fi

if [[ "$1" ]] ; then
  if [[ ! -f "$1" ]] ; then
    echo You specified a .iso file as the first argument, but it does not exist
    cd ../..
    exit 1
  fi
fi

# Load RVM into a shell session *as a function*
if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then
  # First try to load from a user install
  source "$HOME/.rvm/scripts/rvm"
elif [[ -s "/usr/local/rvm/scripts/rvm" ]] ; then
  # Then try to load from a root install
  source "/usr/local/rvm/scripts/rvm"
else
  printf "ERROR: An RVM installation was not found.\n"
  cd ../..
  exit 1
fi

#Install veewee in its own gemset, og_veewee
mkdir veewee
cd veewee
rvm $ruby_version
rvm --force gemset delete og_veewee
rvm gemset create og_veewee
rvm $ruby_version@og_veewee
gem install veewee -v=$veewee_version

#if the iso is provided, then soft link it so it doesn't need to be downloaded
if [[ -f "$1" ]] ; then
  mkdir ./iso
  cd ./iso
  ln -s "$1" $(basename "$1")
  cd ..
fi

#Create the new basebox, using a local iso file if it specified and exists
vagrant basebox define $boxname $veewee_template_name

vagrant basebox build $boxname
vagrant basebox validate $boxname
vagrant basebox export $boxname
vagrant box add $boxname $boxname.box
rm $boxname.box
