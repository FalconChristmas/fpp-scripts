#!/bin/sh
###########################################################
# Remote-StartPlaylist.sh - Start a playlist on a remote  #
#                           system                        #
#                                                         #
# The Playlist will play once and then stop.              #
###########################################################

# Edit this line to hold the playlist name in quotes
PLAYLISTNAME="PUT YOUR PLAYLIST NAME HERE"

# Fill in the IP of the FPP instance where you want to start the playlist
REMOTEIP="PUT YOUR REMOTE FPP IP HERE"

/usr/bin/curl "http://${REMOTEIP}/fppxml.php?command=startPlaylist&playList=${PLAYLISTNAME}"

