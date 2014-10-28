#!/bin/bash
###################################################################
# MP3StreamerStop.sh - Stop Stream Started by MP3StreamerStart.sh #
# v1.0 - Written By MyKroft - Can Be Used Without Restrictions    #
###################################################################

# BINDIR=$(cd $(dirname $0) && pwd)

# . ${BINDIR}/common
#. ${BINDIR}/functions

. /opt/fpp/scripts/common
. /opt/fpp/scripts/functions

# Find Current Volume Setting
CurrentVolume=$(getSetting volume)

# Fade Out Volume
VolumeDecrease=$CurrentVolume

while [ $VolumeDecrease -gt 0 ];  do
  amixer set PCM ${VolumeDecrease}% > /dev/null 2>&1
  let VolumeDecrease=VolumeDecrease-1
  sleep .01
done

# stop mpg123
kill -9 $(cat /tmp/mpg123.pid)

# Set Volume Back To Orig Level
Volume=$(echo "scale=2 ; ${CurrentVolume} / 2.0 + 50" | bc)
amixer set PCM ${Volume}% > /dev/null 2>&1
