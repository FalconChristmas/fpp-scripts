#!/bin/bash
###################################################################
# DisplayStaticImage.sh - Display a static image on the display   #
#                                                                 #
###################################################################

# Fill in your image filename here
IMAGE="YourImageFilename.png"

# By default, images are unknown extensions so left in the upload directory
fbi -T 1 -r 1 --noverbose /home/fpp/media/upload/${IMAGE}

