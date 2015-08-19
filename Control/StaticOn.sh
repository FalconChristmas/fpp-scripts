#!/bin/sh
#############################################################################
# StaticOn.sh - Turn on a block of channels for a static element such as a  #
#               Tune To sign                                                #
#                                                                           #
# NOTE: The channels will stay on until you turn them off using another     #
#       script such as the 'StaticOff.sh' example script.                   #
#############################################################################

# The unique name of the Pixel Overlay Model containing the channel.
# If you use more than one block of channels, you will need to name each
# with a different name in the Pixel Overlay Models screen in FPP.
# 'StaticElements' is used in this example but you could use something like
# 'TuneToSign' to be more specific.
MODEL="StaticElements"

# Turn on the model in overlay mode
fppmm -m ${MODEL} -o on

# Turn on all the channels in the model by setting their values to 255
fppmm -m ${MODEL} -s 255

# You may also comment out the above fppmm lines and uncomment the following
# and copy them if you need to have multiple blocks of channels turn on/off
#
# fppmm -m StaticElements -o on
# fppmm -m StaticElements -s 255

# Another option is to turn on only a single channel in the model using
# a command such as the following command which would turn on channel 32
# at a value of 255.  You still need to run the "-o on" command above to
# enable the block itself, this command only replaces the "-s 255" command
# above which turns on all channels in the block..
#
# fppmm -c 32 -s 255
