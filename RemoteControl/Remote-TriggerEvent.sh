#!/bin/sh
#################################################################
# Remote-TriggerEvent - Trigger an event on a remote system     #
#################################################################

# Fill in the IP of the FPP instance where you want to start the playlist
REMOTEIP="PUT YOUR REMOTE FPP IP HERE"

# Event Major ID
MAJORID="0"

# Event Minor ID
MINORID="0"

/usr/bin/curl "http://${REMOTEIP}/fppxml.php?command=triggerEvent&id=${MAJORID}_${MINORID}"

