#!/bin/bash
###################################################################
# PlayVideoIfNoOtherVideoIsPlaying.sh - Start a video playing     #
#            using cvlc IF there is no other video playing        #
#                                                                 #
# The video will play until it is done playing or cvlc is         #
# stopped.                                                        #
#                                                                 #
###################################################################

# Edit this line to specify the name of the video to play.  The
# video must be a video file in FPP's videos directory.
VIDEOFILE="PutYourVideoFileNameHere.mp4"

###################################################################
# Set some environment variables
. /opt/fpp/scripts/common

if [ -z "$(pgrep cvlc)" ]
then
	sudo -u fpp cvlc --no-video-title-show -q "${MEDIADIR}/videos/${VIDEOFILE}"
fi

