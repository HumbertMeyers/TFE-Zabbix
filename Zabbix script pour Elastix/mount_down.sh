#!/bin/bash
###############
##Check Mount##
###############
NFS_IP="10.101.12.50"

CHECK=$(grep $NFS_IP  /proc/mounts)
if [[ -z $CHECK ]]; then
             echo "0"
else         echo "1"


fi
