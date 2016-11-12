#!/bin/sh

ChangeAmount=$2
STATUS=$(/opt/fpp/bin.pi/fpp -s | cut -d',' -f3)
echo $2

if [ $# -eq 2 -a $1 = "SET" ]; then
setvol=$ChangeAmount
elif [ $# -eq 2 -a $1 = "ADD" ]; then
setvol=$(($STATUS+$ChangeAmount))
elif [ $# -eq 2 -a $1 = "SUBTRACT" ]; then
setvol=$(($STATUS-$ChangeAmount))
fi


if [ $setvol -gt 100 ]; then
setvol=100
fi

if [ $setvol -lt 0 ]; then
setvol=0
fi
echo $ChangeAmount
echo $setvol



/usr/bin/curl "http://localhost/fppxml.php?command=setVolume&volume="$setvol