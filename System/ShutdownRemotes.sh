#!/bin/sh
###########################################################
# ShutdownRemotes.sh - Shutdown the Remote systems        #
#                                                         #
# NOTE: All Remotes must have the "Shutdown.sh" script    #
#       installed from the Script Repository.             #
###########################################################

# Fill in the IP addresses of each remote that you want to shutdown
REMOTE_IPS="IP1 IP2 IP3"

for IP in ${REMOTE_IPS}
do
	echo curl http://${IP}/runEventScript.php?scriptName=Shutdown.sh
done

