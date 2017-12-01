#!/bin/sh

PLATFORM=$(cat /etc/fpp/platform)

if [ "x${PLATFORM}" != "xRaspberry Pi" ]
then
	echo "ERROR: This script only works on the Raspberry Pi SD image"
	exit
fi

. /etc/os-release
OSID=${ID}
OSVER="${ID}_${VERSION_ID}"
if [ "x${OSID}" = "xraspbian" ]
then
    FPPPLATFORM="Raspberry Pi"
    OSVER="debian_${VERSION_ID}"
fi

echo "Downloading patched omxplayer-dist.tgz from github"
case "${OSVER}" in
	debian_9)
		wget -O /tmp/omxplayer-dist.tgz https://github.com/FalconChristmas/fpp-binaries/raw/master/Pi/omxplayer-dist-stretch.tgz
		;;
	debian_7)
		wget -O /tmp/omxplayer-dist.tgz https://github.com/FalconChristmas/fpp-binaries/raw/master/Pi/omxplayer-dist.tgz
		;;
	*)
		echo "ERROR: this script only works on Raspbian Wheezy and Stretch"
		;;
esac

if [ -e /tmp/omxplayer-dist.tgz ]
then
	echo "Extracting omxplayer-dist.tgz to SD card"
	sudo tar xzpvf /tmp/omxplayer-dist.tgz -C /

	echo "Removing omxplayer-dist.tgz"
	rm /tmp/omxplayer-dist.tgz
fi
