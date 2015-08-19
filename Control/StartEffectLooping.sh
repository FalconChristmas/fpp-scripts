#!/bin/sh
###########################################################
# StartEffectLooping - Start an effect in a loop          #
#                                                         #
# The effect will loop until stopped.                     #
###########################################################

# Edit this line to hold the effect name in quotes (WITHOUT the ".eseq" ending)
EFFECTNAME="PUT YOUR EFFECT NAME HERE"

fpp -e "${EFFECTNAME},0,1"

