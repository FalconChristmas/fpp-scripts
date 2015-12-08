#!/bin/bash
###################################################################
# PlayVideoIfNoOtherVideoIsPlaying.sh - Start a video playing     #
#            using omxplayer IF there is no other video playing   #
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

if [ -z "$(pgrep omxplayer.bin)" ]
then
	sudo -u fpp /usr/bin/omxplayer --no-keys ${MEDIADIR}/videos/${VIDEOFILE}
fi

