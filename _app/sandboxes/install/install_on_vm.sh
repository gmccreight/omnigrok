#!/bin/sh

# This script is used to install the sandboxes on a VM

# As we get more base functionality loaded and snapshotted, we can continue to
# make changes on top of that pre-existing functionality.  Occasionally we'll
# drop back to running the whole thing (11-100) just to make sure that the
# whole stack loads properly, but it's much faster to base off of a higher
# snapshot and only run some smaller subset of the install scripts (the ones
# actively being worked on)

#./provisionator.sh og 805,1-100 VB_SNAPSHOT_NAME=about_to_dhclient
#./provisionator.sh og 805,21-100 VB_SNAPSHOT_NAME=after_step_20_and_about_to_dhclient
#./provisionator.sh og 805,31-38 VB_SNAPSHOT_NAME=after_step_30_and_about_to_dhclient
./provisionator.sh og  805,38-100 VB_SNAPSHOT_NAME=after_step_38_and_about_to_dhclient
