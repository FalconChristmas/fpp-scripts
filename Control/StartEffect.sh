#!/bin/sh
###########################################################
# StartEffect - Start an effect on the local system       #
#                                                         #
# The effect will play once and then stop.                #
###########################################################

# Edit this line to hold the effect name in quotes (WITHOUT the ".eseq" ending)
EFFECTNAME="PUT YOUR EFFECT NAME HERE"

fpp -e "${EFFECTNAME}"

