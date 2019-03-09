#!/bin/sh
###########################################################
# GPIO-Off.sh - Turn off one of the Pi's GPIO Outputs     #
###########################################################

# Set the GPIO number (NOT the pin value).
GPIO="0"


# Make sure the pin is setup for output.
/opt/fpp/src/fpp -G ${GPIO},Output

# Turn off the pin
/opt/fpp/src/fpp -g ${GPIO},Output,0

