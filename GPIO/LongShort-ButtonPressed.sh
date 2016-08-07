#!/bin/sh
#############################################################################
# LongShort-ButtonPressed.sh
#
# This script is used in conjunction with the LongShort-ButtonReleased.sh
# script to allow a single button to serve two functions.  When the button
# is held for a short period of time, the first action is performed and when
# the button is held for a long period of time, the second action is
# performed.  This script initiates the button press timer by recording
# the time when the button was pressed.
#############################################################################

date +%s.%N > /var/tmp/buttonPressed.txt

