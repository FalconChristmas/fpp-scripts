#!/bin/sh
#################################################################
# Remote-RunScript.sh - Run a script on a remote system         #
#################################################################

# Fill in the IP of the FPP instance where you want to start the playlist
REMOTEIP="PUT YOUR REMOTE FPP IP HERE"

# Fill in the name of the script to run here
SCRIPT="PUT YOUR SCRIPT NAME HERE"

/usr/bin/curl "http://${REMOTEIP}/runEventScript.php?scriptName=${SCRIPT}"

