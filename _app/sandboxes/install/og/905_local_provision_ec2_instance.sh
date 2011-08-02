#This script creates a new instance and associates an IP address with it.

source __shared/library.sh
load_var PROVISIONING_USER
load_var SSH_SPECIAL_OPTIONS
load_var SSH_PORT
load_var URI

#get the pre-existing instance id by ssh'ing to the server and asking it
preexisting_instance_id=$(ssh $SSH_SPECIAL_OPTIONS -p $SSH_PORT $PROVISIONING_USER@$URI "curl -s http://169.254.169.254/latest/meta-data/instance-id")

echo info: terminating pre-existing instance
ec2-terminate-instances $preexisting_instance_id
sleep 10

# Ubuntu 11.04 using EBS on a small instance in US East. We don't use a micro
# instance immediately because of the
# [tag:micro_instance_java_installation_issue:gem], but rather we start with a
# small and downgrade to a micro after all the installation is done.
result=`ec2-run-instances -t m1.small -k gmcckey ami-06ad526f`
instance_id=`echo $result | egrep -o "\W(i-[a-zA-Z0-9]{8})" | egrep -o "[a-zA-Z0-9-]+"`

echo info: sleeping 20 to give the new instance time to start running before we try to associate the IP address with it
sleep 20

ec2-associate-address 107.20.217.248 -i $instance_id

#Remove omnigrok from the known_hosts file so you don't get errors when you try
#to SSH to the new one
ssh-keygen -f "/home/gmccreight/.ssh/known_hosts" -R omnigrok.com
ssh-keygen -f "/home/gmccreight/.ssh/known_hosts" -R 107.20.217.248

echo info: sleeping 30 to ensure that the machine is up and running before the script is done
sleep 30
