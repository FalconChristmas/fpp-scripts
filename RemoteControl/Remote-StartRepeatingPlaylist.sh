#!/bin/sh
###########################################################
# Remote-StartRepeatingPlaylist.sh - Start a repeating    #
#                                    playlist on a remote #
#                                    system               #
#                                                         #
# The Playlist will play repeatedly until stopped.        #
###########################################################

# Edit this line to hold the playlist name in quotes
PLAYLISTNAME="PUT YOUR PLAYLIST NAME HERE"

# Fill in the IP of the FPP instance where you want to start the playlist
REMOTEIP="PUT YOUR REMOTE FPP IP HERE"

/usr/bin/curl "http://${REMOTEIP}/fppxml.php?command=startPlaylist&playList=${PLAYLISTNAME}&repeat=checked"

