#!/bin/sh

PLAYLISTNAME=$2

/opt/fpp/bin.pi/fpp -S

STATUS=$(/opt/fpp/bin.pi/fpp -s | cut -d',' -f2)

STATUS=1
while [ $STATUS != '0' ]
do
STATUS=$(/opt/fpp/bin.pi/fpp -s | cut -d',' -f2)
sleep 2
done

/opt/fpp/bin.pi/fpp -P "${PLAYLISTNAME}"