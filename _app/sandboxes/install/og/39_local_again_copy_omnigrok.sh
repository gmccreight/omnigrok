#Copy the omnigrok project to the newly provisioned Ubuntu server again
#without the two directories that will be linked in.

source __shared/library.sh
load_var PROVISIONING_USER
load_var URI

rsync -av --exclude ".git" --exclude "_app/local" --exclude "_app/og_tests/frameworks" --delete ../../../../../omnigrok/ $PROVISIONING_USER@$URI:~/omnigrok/
