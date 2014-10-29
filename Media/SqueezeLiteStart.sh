#!/bin/sh
##############################################################################
# SqueezeLiteStart.sh - Start squeezelite to turn FPP into a Squeeze player
##############################################################################
# To use this script with FPP v0.4.0, you must first install
# squeezelite-armv6hf. Login to the Pi via SSH and run the following commands:
#
# cd /usr/bin
# sudo wget http://squeezelite-downloads.googlecode.com/git/squeezelite-armv6hf
# sudo chmod 755 squeezelite-armv6hf
#
#---------
#
# Once you have installed squeezelite, edit the 'SERVER' variable below to
# contain the IP address or hostname of your LMS server.
#
##############################################################################
# Script Actions - These are automatically executed in FPP v1.0 and higher
# InstallAction: sudo wget -q -O /usr/bin/squeezelite-armv6hf http://squeezelite-downloads.googlecode.com/git/squeezelite-armv6hf
# InstallAction: sudo chmod 755 /usr/bin/squeezelite-armv6hf
##############################################################################

##############################################################################
# To connect to a specific LMS server, fill in the server's IP address
# in the following SERVER variable.  ie,  SERVER="192.168.1.100"
##############################################################################
SERVER=""

##############################################################################
# Use the hostname configured via the FPP Web UI
##############################################################################
HOSTNAME=$(hostname)

##############################################################################
# To not set the hostname and instead let the identifier be set on the LMS
# server, uncomment the following line to clear the HOSTNAME variable
#
# HOSTNAME=""

#############################################################################

if [ "x${SERVER}" != "x" ]
then
	SERVER="-s ${SERVER}"
fi

if [ "x${HOSTNAME}" != "x" ]
then
	HOSTNAME="-n ${HOSTNAME}"
fi

sudo /usr/bin/squeezelite-armv6hf -z ${SERVER} ${HOSTNAME}

