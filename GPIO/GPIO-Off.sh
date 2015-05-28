#!/bin/sh
###########################################################
# GPIO-OutputOn.sh - Turn on one of the Pi's GPIO Outputs #
###########################################################

# GPIO Pin # on the Pi.  These are numbered 0-7 on the main
# 26-pin header on a A & B.  A model B+ has more available.
# For the PiFace, use 200-207.
PIN="0"

OPTS=""
if [ ${PIN} -gt 200 ]
then
	OPTS="-p"
fi

# Make sure the pin is setup for output.
/usr/local/bin/gpio ${OPTS} mode ${PIN} out

# Turn off the pin
/usr/local/bin/gpio ${OPTS} write ${PIN} 0

