#!/bin/bash

set -e

if [ "$HOSTNAME" != "$SGEMASTER" ]; then
   echo "++++++++++++++++++++++Configuring SGE with new Master++++++++++++++++++++++++++++"
   echo "$HOSTNAME" >  /var/lib/gridengine/default/common/act_qmaster
   echo "domain $HOSTNAME" >> /etc/resolv.conf
   service gridengine-master restart
   sleep 1
   qconf -mattr "queue" "hostlist" "$HOSTNAME" "compute.q"
   qconf -as $HOSTNAME
   echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
fi

# Run whatever the user wants to
exec "$@"