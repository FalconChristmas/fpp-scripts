#!/bin/sh
###########################################################
# StartRepeatingPlaylist.sh - Start a repeating playlist  #
#                             on the local system         #
#                                                         #
# The Playlist will play repeatedly until stopped.        #
###########################################################

# Edit this line to hold the playlist name in quotes
PLAYLISTNAME="PUT YOUR PLAYLIST NAME HERE"

# If you want to start on a specfic numbered entry in the playlist
# then put the entry number inside the quotes on the line below
STARTITEM=""

fpp -p "${PLAYLISTNAME}" ${STARTITEM}

