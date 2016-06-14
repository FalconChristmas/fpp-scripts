#!/bin/sh
##############################################################################
# StaticOff.sh - Turn OFF a block of channels for a static element such as a #
#                Tune To sign                                                #
#                                                                            #
# NOTE: The channels will stay on until you turn them off using another      #
#       script such as the 'StaticOff.sh' example script.                    #
##############################################################################

# The unique name of the Pixel Overlay Model containing the channel.
# If you use more than one block of channels, you will need to name each
# with a different name in the Pixel Overlay Models screen in FPP.
# 'StaticElements' is used in this example but you could use something like
# 'TuneToSign' to be more specific.
MODEL="StaticElements"

# Turn off all the channels in the model by setting their values to 255
fppmm -m ${MODEL} -s 0

# Sleep a little to let the new value be sent otu to the controllers
sleep 1

# Turn off the model in overlay mode
fppmm -m ${MODEL} -o off

# You may also comment out the above fppmm lines and uncomment the following
# and copy them if you need to have multiple blocks of channels turn on/off
#
# fppmm -m StaticElements -s 0
# fppmm -m StaticElements -o off

# Another option is to turn off only a single channel in the model using
# a command such as the following command which would turn off channel 32.
# In this case, you DO NOT want to run the "-o off" command above because
# this would turn the whole block off.
#
# fppmm -c 32 -s 0
