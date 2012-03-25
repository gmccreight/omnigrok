#!/bin/bash

# ./_app/vm/create_vagrant_box_from_veewee_template.sh

# Create a vagrant box using a veewee template

#------------------------------------------------------------------------------
# Configuration
#------------------------------------------------------------------------------

ruby_version="1.9.3"
veewee_version="0.2.3"
veewee_template_name="ubuntu-11.10-server-i386"
name_of_box_to_create="oneiric32"

if [[ -f ~/.omnigrokrc ]]; then
  source ~/.omnigrokrc
else
  echo optional: you might consider adding a ~/.omnigrokrc file with:
  echo export locally_saved_oneiric32_iso_file=some/path/to/the/locally/saved/ubuntu-11.10-server-i386.iso
fi

if [[ "$locally_saved_oneiric32_iso_file" ]] ; then
  if [[ ! -f "$locally_saved_oneiric32_iso_file" ]] ; then
    echo You specified a locally_saved_oneiric32_iso_file in your ~/.omnigrokrc, but it does not exist
    exit 1
  fi
fi


#------------------------------------------------------------------------------
# Move into right directory
#------------------------------------------------------------------------------

cd ./_app/vm


#------------------------------------------------------------------------------
# RVM
#------------------------------------------------------------------------------

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

# Install veewee in its own gemset, og_veewee
rvm $ruby_version
rvm --force gemset delete og_veewee
rvm gemset create og_veewee
rvm $ruby_version@og_veewee
gem install veewee -v=$veewee_version


#------------------------------------------------------------------------------
# Possibly cleanup last installation - needs RVM
#------------------------------------------------------------------------------

if [[ -d ./veewee ]]; then
  cd veewee
  vagrant destroy 2>/dev/null
  vagrant box remove $name_of_box_to_create 2>/dev/null
  vagrant basebox destroy $name_of_box_to_create 2>/dev/null
  vagrant basebox undefine $name_of_box_to_create 2>/dev/null
  cd ..
  rm -rf ./veewee
fi


# #------------------------------------------------------------------------------
# # Install the vagrant box from the template
# #------------------------------------------------------------------------------

mkdir veewee
cd veewee

# if the iso is provided, then soft link it so it doesn't need to be downloaded
if [[ -f $locally_saved_oneiric32_iso_file ]] ; then
  mkdir ./iso
  cd ./iso
  ln -s "$locally_saved_oneiric32_iso_file" $(basename "$locally_saved_oneiric32_iso_file")
  cd ..
fi

#Create the new basebox, using a local iso file if it specified and exists
vagrant basebox define $name_of_box_to_create $veewee_template_name

vagrant basebox build $name_of_box_to_create
vagrant basebox validate $name_of_box_to_create
vagrant basebox export $name_of_box_to_create
vagrant box add $name_of_box_to_create $name_of_box_to_create.box
rm $name_of_box_to_create.box
