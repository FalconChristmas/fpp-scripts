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

SERVER="192.168.1.1"

#############################################

HOSTNAME=$(hostname)

sudo /usr/bin/squeezelite-armv6hf -s ${SERVER} -n ${HOSTNAME} -z

