#!/bin/sh
###########################################################
# ShutdownRemotes.sh - Shutdown the Remote systems        #
#                                                         #
# NOTE: All Remotes must have the "Shutdown.sh" script    #
#       installed from the Script Repository.             #
###########################################################

# Use scheduler Args to pass IPs/names to eliminate the need to manually edit and maintain a script file

for IP in ${@}
do
	curl http://${IP}/runEventScript.php?scriptName=Shutdown.sh
done

