#!/bin/sh
###########################################################
# Remote-StartEffect.sh - Start an effect on a remote FPP #
#                         system.                         #
#                                                         #
# The Effect will play once or loop depending on the      #
# value of the LOOP variable below.                       #
###########################################################

# Fill in the IP address of the remote FPP instance here
HOST=PutYourRemoteIPHere
# Put the effect name here (without the .eseq extension)
EFFECT=PutYourEffectNameHere

###########################################################
# Stop the effect
curl "http://${HOST}/fppxml.php?command=stopEffectByName&effect=${EFFECT}"

