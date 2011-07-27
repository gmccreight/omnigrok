#Copy the omnigrok project to the newly provisioned Ubuntu server

source __shared/library.sh
load_var PROVISIONING_USER
load_var URI

rsync -av --exclude "_app/local/*" --delete ../../../../../omnigrok/ $PROVISIONING_USER@$URI:~/omnigrok/
