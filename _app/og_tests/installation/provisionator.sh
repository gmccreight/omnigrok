#!/bin/sh
#
# This provisioning script works like this:
#
standard_usage="
                   dir        steps to         __config.txt file overrides
                   \          run (or all)    /
                    \          \             /
                     \________  \_________  /__________________
 ./provisionator.sh  app_server  1,6-10,14  URI=192.168.168.102,SSH_PORT=30101
 "
# === More usage examples ===
#
# If you'd like to run 31 - 50, starting with a "step_30_done" snapshot that
# you start as part of step 999, which is a virtualbox loading script:
# ./provisionator.sh mm_app_server 999,31-50 VB_SNAPSHOT_NAME=step_30_done,URI=192.168.168.102
#
# === The provisioning directory structure ===
#
# app_server/
#   __config.txt
#       Required. Does not get run directly... contains readme-style info and
#       shared config info that the other steps can use.  It is used in
#       combination with the overrides to create a __config_generated.txt file
#       that has options specified on the command line as at higher precedence.
#   __config_local.txt
#       Optional. Does not get run directly... contains readme-style info and
#       shared config info that the other steps can use.  It has higher
#       precedence than the __confi.txt file.  It is used in combination with
#       __config.txt file and the overrides to create a __config_generated.txt
#       file that has options specified on the command line as at higher
#       precedence.  It is seperated from __config.txt in case you want to have
#       some options that you do not want to have in version control.
#   __shared
#       Not required, but can be very helpful.  Any files placed in this folder
#       will be available both locally and remotely.  For example, you could
#       put a shared library in there or some configuration files.
#   15_local_security_and_ssh_which_is_run_locally.sh
#       If the filename starts with "local" it will be executed locally.
#   20_sudo_some_commands_to_run_as_sudo.sh
#       If the filename starts with "sudo" it will be run remotely with sudo.
#   30_some_non_sudo_commands.sh
#       If the filename does not start with sudo, it will not be run as sudo.
#
# === Assumptions ===
#   * You have an SSH public key that will be copied to the remote machine,
#       allowing password-less provisioning.
#
# === Goals ===
#   * To stick with bash because it is ubiquitous and it maps very closely to
#       how install commands are normally run.
#   * To keep it as simple as possible, and aim for editabilty and clarity.

provisioning_folder=$1
steps=$2
overrides=$3

error=0

if [ ! -d "$provisioning_folder" ]; then
    echo ""
    echo ERROR: the provisioning_folder \"$provisioning_folder\" does not exist
    error=1
fi

if [ ! -f "$provisioning_folder/__config.txt" ]; then
    echo ""
    echo ERROR: the required __config.txt file does not exist in the provisioning_folder \"$provisioning_folder\"
    error=1
fi

if [ `echo $steps | grep "^[0-9,-]\+$" | wc -l` -eq 0 ] ; then
    if [ $steps = "all" ] ; then
        steps="1-10000"
    else
        echo ""
        echo ERROR: the steps should either be formatted like 1-9,14,15 or should be "all" without the quotes
        error=1
    fi
fi

if [ $error -eq 1 ] ; then
    # double quotes necessary to preserve the whitespace in the standard_usage
    echo "$standard_usage"
    exit
fi

########## Steps ##########
# expand steps defined like: 10,15,18-21 into 10 15 18 19 20 21
steps=$(eval $(eval "echo $steps | sed 's/,/ /g' | sed 's/\([^ ]\+\)/echo \1;/g' | sed 's/\([0-9]\+\)-\([0-9]\+\)/\`seq \1 \2\`/g'"))

########## Overrides ##########
# Take options on the command line like this:
# URI=192.168.168.102,SSH_PORT=30101,VB_SNAPSHOT_NAME="my snapshot"
# And turn them into:
#   URI="192.168.168.102"
#   SSH_PORT="30101"
#   VB_SNAPSHOT_NAME="my snapshot"
#
# Then, append them to the __config_generated.txt file so they will override
# pre-existing configuration options.

cd $provisioning_folder

cp -a __config.txt __config_generated.txt
if [ -f __config_local.txt ]; then
 cat __config_local.txt >> __config_generated.txt
fi
echo "\n\n### OVERRIDES ###\n\n" >> __config_generated.txt

overrides=$(eval "echo $overrides | sed 's/=/=\"/g' | sed 's/$/\"/' | sed 's/,/\"\\\n/g'")
echo $overrides >> __config_generated.txt

eval `grep "^PROVISIONING_USER=" __config_generated.txt`
eval `grep "^SSH_PORT="          __config_generated.txt`
eval `grep "^URI="               __config_generated.txt`

cp_to_remote() {
    scp -r -P $SSH_PORT $1 $PROVISIONING_USER@$URI:~/$provisioning_folder
}

do_on_remote() {
    ssh -p $SSH_PORT $PROVISIONING_USER@$URI $1
}

for i in $steps; do
    if [ `ls ./${i}_*.sh 2>/dev/null | wc -l` -gt 0 ]; then   
        echo starting step $i
        if [ `ls ./${i}_*.sh 2>/dev/null | egrep "/[0-9]+_local_" | wc -l` -gt 0 ]; then
            # If the file is "local", then run it locally
            bash ./${i}_*.sh
        else
            # Create the provisioning folder in the provisioning user's home directory and copy the
            # configuration file there so that the rest of the scripts can use it.
            do_on_remote "mkdir $provisioning_folder 2>/dev/null"
            cp_to_remote ./__config_generated.txt

            #Recursively copy the __shared folder to the remove location
            if [ `ls ./__shared 2>/dev/null | wc -l` -gt 0 ]; then
                cp_to_remote __shared
            fi

            cp_to_remote ./${i}_*.sh

            is_sudo=""
            if [ `ls ./${i}_*.sh 2>/dev/null | egrep "/[0-9]+_sudo_" | wc -l` -gt 0 ]; then
                is_sudo="sudo"
            fi
            echo running as $is_sudo $PROVISIONING_USER
            do_on_remote "cd $provisioning_folder; $is_sudo bash ./${i}_*.sh"
            do_on_remote "rm -rf $provisioning_folder"
        fi
        echo step $i complete
    fi
done
