#!/bin/sh
###################################################################
# MP3StreamerStart.sh - Stream live stream from internet          #
#                                                                 #
# Will Play Until MP3StreamerStop.sh Is Called                    #
#                                                                 #
###################################################################

# Edit this line to hold the URL of the stream:port in quotes
STREAMURL="http://relay5.181.fm:11082"

# Edit this line to hold any options required in quotes
STREAMOPTIONS="-q --no-video-title-show"

cvlc ${STREAMOPTIONS} ${STREAMURL} &
echo $! >/var/run/mp3streamer.pid

