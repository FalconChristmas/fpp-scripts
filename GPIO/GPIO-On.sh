#!/bin/sh
###########################################################
# GPIO-On.sh - Turn on one of the Pi's GPIO Outputs       #
###########################################################

# Set the GPIO number (NOT the pin number)
GPIO="0"

# Make sure the pin is setup for output.
/opt/fpp/src/fpp -G ${GPIO},Output

# Turn on the pin
/opt/fpp/src/fpp -g ${GPIO},Output,1

