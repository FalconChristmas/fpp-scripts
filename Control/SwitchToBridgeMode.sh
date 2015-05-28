#!/bin/sh
###########################################################
# SwitchToBridgeMode.sh - Switch a running FPP instance   #
#                         to bridge mode and restart FPPD #
#                                                         #
# NOTE: Any running playlist will be stopped.             #
###########################################################


# Stop FPP daemon
fppd_stop

# Switch config to bridge mode
sed -i "s/fppMode.*=.*/fppMode = bridge/" ${FPPHOME}/media/settings

# Restart FPP daemon
fppd_start

