source __shared/library.sh

#This script creates a new instance and associates an IP address with it.

#Ubuntu 11.04 using EBS on a micro instance in US East
result=`ec2-run-instances -t t1.micro -k gmcckey ami-06ad526f`
instance_id=`echo $result | egrep -o "\W(i-[a-zA-Z0-9]{8})" | egrep -o "[a-zA-Z0-9-]+"`

echo sleeping 10 to give the new instance time to start running before we try to associate the IP address with it
sleep 10

ec2-associate-address 107.20.217.248 -i $instance_id
