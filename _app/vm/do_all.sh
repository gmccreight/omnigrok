#!/bin/bash

# ./_app/vm/do_all.sh

cd ./_app/vm
./create_vagrant_vm.sh
vagrant up
vagrant ssh -c "cd /og/_app; ./install.sh"
vagrant ssh -c "cd /og/; ./_app/og_tests/test_all.sh"
cd ../..
