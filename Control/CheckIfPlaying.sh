#!/bin/sh
###########################################################
# CheckIfPlaying.sh - Run scripts based on whether or not #
# FPP is currently playing a sequence of some sort.       #
###########################################################

# Edit this line to hold the script name to run if nothing is currently being played
SCRIPT_IF_NOT_PLAYING="PUT YOUR SCRIPT NAME HERE (NOT PlAYING)"

# Edit this line to hold the script name to run if something is currently playing
SCRIPT_IF_PLAYING="PUT YOUR SCRIPT NAME HERE (PLAYING)"



###########################################################
# Guts of the script.  You probably don't need to edit    #
# anything below this block                               #
###########################################################

# Get our current status
STATUS=$(fpp -s | cut -d',' -f2)

# Check that we got something meaningful
if [ -z "${STATUS}" ]; then
	echo "Error with status value" >&2
	exit 1
fi

# Act on the current status
case ${STATUS} in
	# IDLE
	0)
		if [ -e "${MEDIADIR}/scripts/${SCRIPT_IF_NOT_PLAYING}" ]; then
			eventScript "${MEDIADIR}/scripts/${SCRIPT_IF_NOT_PLAYING}"
		fi
		;;
	# PLAYING
	1)
		if [ -e "${MEDIADIR}/scripts/${SCRIPT_IF_PLAYING}" ]; then
			eventScript "${MEDIADIR}/scripts/${SCRIPT_IF_PLAYING}"
		fi
		;;
	# STOPPING GRACEFULLY
	2|*)
		# Do nothing for stopping gracefully for now, or unknown
		;;
esac
