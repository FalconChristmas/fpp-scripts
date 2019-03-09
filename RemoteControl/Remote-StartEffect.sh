#!/bin/sh
###########################################################
# Remote-StartEffect.sh - Start an effect on a remote FPP #
#                         system.                         #
#                                                         #
# The Effect will play once or loop depending on the      #
# value of the LOOP variable below.                       #
###########################################################

# Fill in the IP address of your remote FPP instance
HOST=PutYourRemoteIPHere
# Fill in the name of the effect sequence to run (without the .eseq extension)
EFFECT=PutYourEffectNameHere
# Set to 1 to loop or 0 to not loop
LOOP=1

###########################################################
# Start the Effect
curl "http://${HOST}/fppxml.php?command=playEffect&effect=${EFFECT}&startChannel=0&loop=${LOOP}"

