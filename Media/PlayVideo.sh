#!/bin/bash
###################################################################
# PlayVideo.sh - Start a video playing using cvlc                 #
#                                                                 #
# The video will play until it is done playing or cvlc is         #
# stopped.                                                        #
#                                                                 #
###################################################################

# Edit this line to specify the name of the video to play.  The
# video must be a file in FPP's videos directory.
VIDEOFILE="PutYourVideoFileNameHere.mp4"

###################################################################
# Set some environment variables
. /opt/fpp/scripts/common

sudo -u fpp cvlc -q "${MEDIADIR}/videos/${VIDEOFILE}"

