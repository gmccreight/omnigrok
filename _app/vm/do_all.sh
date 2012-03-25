#!/bin/bash

# ./_app/vm/do_all.sh

#-----------------------------------------------------------------------------
# Build the box
#-----------------------------------------------------------------------------

./_app/vm/create_vagrant_box_from_veewee_template.sh

#-----------------------------------------------------------------------------
# Install the software on it
#-----------------------------------------------------------------------------

cd ./_app/vm

# Load RVM into a shell session *as a function*
if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then
  # First try to load from a user install
  source "$HOME/.rvm/scripts/rvm"
elif [[ -s "/usr/local/rvm/scripts/rvm" ]] ; then
  # Then try to load from a root install
  source "/usr/local/rvm/scripts/rvm"
else
  printf "ERROR: An RVM installation was not found.\n"
  exit 1
fi

rvm 1.9.3@og_veewee

vagrant destroy 2>/dev/null #In case there is a pre-existing box derived from the oneiric32 basebox
vagrant up
vagrant ssh -c "cd /og/_app; ./install.sh"
vagrant ssh -c "cd /og/; ./_app/og_tests/test_all.sh"
cd ../..
