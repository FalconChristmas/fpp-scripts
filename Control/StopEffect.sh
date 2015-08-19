#!/bin/sh
###########################################################
# StopEffect - Stop a running effect by name              #
#                                                         #
# The effect will stop immediately                        #
###########################################################

# Edit this line to hold the effect name in quotes (WITHOUT the ".eseq" ending)
EFFECTNAME="PUT YOUR EFFECT NAME HERE"

fpp -E "${EFFECTNAME}"

