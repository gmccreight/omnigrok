#Copy the rosetta_cs project to the newly provisioned Ubuntu server again

source __shared/library.sh
load_var PROVISIONING_USER
load_var URI

rsync -av --exclude "_app/local" --delete ../../../../../rosetta_cs/ $PROVISIONING_USER@$URI:~/rcs/
