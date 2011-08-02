# This script sets the instance to being a t1.micro instance
# It's a workaround which addresses the [tag:micro_instance_java_installation_issue:gem].

source __shared/library.sh
load_var PROVISIONING_USER
load_var SSH_SPECIAL_OPTIONS
load_var SSH_PORT
load_var URI

#get the instance id by ssh'ing to the server and asking it
instance_id=$(ssh $SSH_SPECIAL_OPTIONS -p $SSH_PORT $PROVISIONING_USER@$URI "curl -s http://169.254.169.254/latest/meta-data/instance-id")

echo stopping instance $instance_id then sleeping 60 seconds
ec2-stop-instances $instance_id
sleep 60

echo modifying the instance attribute $instance_id then sleeping 60 seconds
ec2-modify-instance-attribute $instance_id --instance-type t1.micro
sleep 60

echo starting instance $instance_id again then sleeping 60
ec2-start-instances $instance_id
sleep 60

echo reassociating the elastic IP then sleeping 20
ec2-associate-address 107.20.217.248 -i $instance_id
sleep 20
