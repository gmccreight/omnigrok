#!/bin/sh

# This script is used to install the sandboxes on ec2

./provisionator.sh og 905,1-100,990 SSH_SPECIAL_OPTIONS="-o StrictHostKeyChecking\\\\=no -i /home/gmccreight/.ssh/gmcckey.pem",URI=omnigrok.com
