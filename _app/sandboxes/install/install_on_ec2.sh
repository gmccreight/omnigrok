#!/bin/sh

# This script is used to install the sandboxes on ec2

#./provisionator.sh og 905,1-100 SSH_IDENTITY_FILE="~/.ssh/gmcckey.pem"
./provisionator.sh og 1-100 SSH_IDENTITY_FILE="/home/gmccreight/.ssh/gmcckey.pem",URI=omnigrok.com
