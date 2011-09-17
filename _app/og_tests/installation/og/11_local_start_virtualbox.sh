source __shared/library.sh
load_var VB_VM_NAME
load_var VB_SNAPSHOT_NAME
load_var URI

#--- End configuration and settings

# The base installation of the VM should be as close to Amazon or Slicehost's base installation as possible.
# Can get the snapshot UUID by doing a VBoxManage showvminfo on the VB_VM_NAME
VBoxManage controlvm "$VB_VM_NAME" poweroff 2> /dev/null

sleep 1

# Wait for the VM to totally power down before trying to start it back up again
while [ `ps aux | grep "$VB_VM_NAME" | grep -v grep | wc -l` -ne 0 ]; do 
    sleep 1
done

snapshot_uuid=`VBoxManage showvminfo "$VB_VM_NAME" | grep "Name: $VB_SNAPSHOT_NAME" | egrep --only-matching "[a-z0-9]+-[a-z0-9]+-[a-z0-9]+-[a-z0-9]+-[a-z0-9]+"`

VBoxManage snapshot "$VB_VM_NAME" restore $snapshot_uuid
VBoxManage startvm "$VB_VM_NAME"

# Wait for the server to start and become available
while [ `ping -c 1 $URI | grep "bytes from" | wc -l` -eq 0 ]; do 
    echo Waiting for server to become available at $URI
done
