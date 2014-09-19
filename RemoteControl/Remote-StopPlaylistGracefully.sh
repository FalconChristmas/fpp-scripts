#!/bin/sh
############################################################
# Remote-StopPlaylistGracefully.sh - Stop a remote running #
#                                    playlist gracefully   #
############################################################

# Fill in the IP of the FPP instance where you want to start the playlist
REMOTEIP="PUT YOUR REMOTE FPP IP HERE"

/usr/bin/curl "http://${REMOTEIP}/fppxml.php?command=stopGracefully"

