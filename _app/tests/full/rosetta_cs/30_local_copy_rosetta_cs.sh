#Copy the rosetta_cs project to the newly provisioned Ubuntu server

source __shared/library.sh
load_var PROVISIONING_USER
load_var URI

scp -r ../../../../../rosetta_cs $PROVISIONING_USER@$URI:~/rcs
