#!/bin/bash

#############################################################################
# Remove the blacklist file we created to disable onboard WiFi.
# NOTE: Reboot after running!
#############################################################################

sudo rm /etc/modprobe.d/wifi-blacklist.conf
