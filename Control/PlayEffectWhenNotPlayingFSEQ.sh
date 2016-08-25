#!/bin/sh
###########################################################
# PlayEffectWhenNotPlayingFSEQ.sh - Play a looping effect #
#     sequence whenever FPP is not playing a regular      #
#     fseq sequence.                                      #
###########################################################

# Fill in the name of the effect to loop here
EFFECT_NAME="effectToLoop"

# Update this number if you want to check less often than once per second.
# This variable should be set to the number of seconds you want to wait
# between checks.
SLEEP_TIME=1
###########################################################
PLAYING=0

while /bin/true
do
    STATUS=$(fpp -s)

    if [ "x${STATUS}" != "xfalse" ]
    then
		# We received a response from fppd so parse it
        FSEQ=$(fpp -s | cut -f4 -d,)

        if [ "x${FSEQ}" != "x" ]
        then
            # We ARE currently playing a .fseq
            if [ ${PLAYING} -eq 0 ]
            then
                # We aren't playing the effect, so do nothing
            else
                # We are playing the effect, so stop it from looping
                fpp -E ${EFFECT_NAME}

                PLAYING=0
            fi
        else
            # We are NOT currently playing a .fseq
            if [ ${PLAYING} -eq 0 ]
            then
                # We aren't playing the effect, so start it looping
                fpp -e ${EFFECT_NAME},0,1

                PLAYING=1
            else
                # We are playing the effect, so do nothing
            fi
        fi
    else
        # fppd isn't responding or isn't running
    fi

    sleep ${SLEEP_TIME}
done

