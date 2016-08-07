#!/bin/sh
#############################################################################
# LongShort-ButtonReleased
#
# This script is used in conjunction with the LongShort-ButtonPressed
# script to allow a single button to serve two functions.  When the button
# is held for a short period of time, the first action is performed and when
# the button is held for a long period of time, the second action is
# performed.  This script checks the time when the button is released and
# compares it against the time when the button was pressed.  If the duration
# was longer than the "LONGPRESS" value then the Long action is performed,
# otherwise the Short action is performed.
#
# You will need to edit 3 places in this script.  The first is the LONGPRESS
# value below this comment.  This value is in milliseconds, so '2000'
# indicates the button must be pressed for 2 seconds or more.  The other
# two locations to modify are at the bottom of the script.  These will be
# the short and long actions to take when the button is released.
#############################################################################


# Specify the number of milliseconds for a Long Press here
LONGPRESS=1000

##########################################################################

NOW=$(date +%s.%N)
PRESSED=$(cat /var/tmp/buttonPressed.txt)

DIFF=$(echo "(${NOW} * 1000) - (${PRESSED} * 1000)" | bc | cut -f1 -d\.)

if [ ${DIFF} -ge ${LONGPRESS} ]
then
	# Put your long press action code here
	echo "That was a long press, DIFF = ${DIFF}."
else
	# Put your short press action code here
	echo "That was a short press, DIFF = ${DIFF}."
fi

