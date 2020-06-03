#!/usr/bin/env bash

# The output of slurmd -C looks like this:
#
# NodeName=48e0b5340c36 CPUs=12 Boards=1 SocketsPerBoard=1 CoresPerSocket=6 ThreadsPerCore=2 RealMemory=15804
# UpTime=2-21:37:11

# We want to take some of this content and put it at the end of the
# slurm configure file. Which will look like this:
#
# NodeName=48e0b5340c36 CPUs=1 State=UNKNOWN
# PartitionName=debug Nodes=48e0b5340c36 Default=YES MaxTime=INFINITE State=UP
# ControlMachine=48e0b5340c36

conf_file=/etc/slurm-llnl/slurm.conf

node_info=$(slurmd -C)

node_name=$(echo "$node_info" | awk -F'[= ]' 'NR==1{print $2;}')
cpus=$(echo "$node_info" | awk -F'[= ]' 'NR==1{print $4;}')

# Finish filling out the conf file based on the image and CPU info
echo "NodeName=$node_name CPUs=$cpus State=UNKNOWN" >> $conf_file
echo "PartitionName=debug Nodes=$node_name Default=YES MaxTime=INFINITE State=UP" >> $conf_file
echo "ControlMachine=$node_name" >> $conf_file

# Start up all of our services now
service munge start
service slurmctld start
service slurmd start

# Setup docker group
DOCKER_SOCKET=/var/run/docker.sock
DOCKER_GROUP=docker

if [[ -S ${DOCKER_SOCKET} && $(getent group ${DOCKER_GROUP}) ]]; then
   DOCKER_GID=$(stat -c '%g' ${DOCKER_SOCKET})
   groupmod -g ${DOCKER_GID} ${DOCKER_GROUP}
   usermod -aG ${DOCKER_GROUP} demo
fi

# Run whatever the user wants to
exec "$@"
