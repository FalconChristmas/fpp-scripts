#!/bin/bash
###################################################################
# PlayVideo.sh - Start a video playing using omxplayer            #
#                                                                 #
# The video will play until it is done playing or omxplayer is    #
# stopped.                                                        #
#                                                                 #
###################################################################

# Edit this line to specify the name of the video to play.  The
# video must be a .mp4 file in FPP's videos directory.
VIDEOFILE="PutYourVideoFileNameHere.mp4"

###################################################################
# Set some environment variables
. /opt/fpp/scripts/common

sudo -u fpp /usr/bin/omxplayer --no-keys "${MEDIADIR}/videos/${VIDEOFILE}"

