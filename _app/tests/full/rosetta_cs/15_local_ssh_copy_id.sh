source __shared/library.sh
load_var USER_NAME
load_var USER_PASS
load_var URI

# Copy the id file so we can simply SSH from now on.
expect <<ExpectInput
spawn ssh-copy-id "-o StrictHostKeyChecking=no $USER_NAME@$URI"
expect "$USER_NAME@$URI's password:"
send -- "$USER_PASS\r"
send -- "\r"
ExpectInput
