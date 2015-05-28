#!/bin/sh
###########################################################
# SwitchToRemoteMode.sh - Switch a running FPP instance   #
#                         to remote mode and restart FPPD #
#                                                         #
# NOTE: Any running playlist will be stopped.             #
###########################################################


# Stop FPP daemon
fppd_stop

# Switch config to remote mode
sed -i "s/fppMode.*=.*/fppMode = remote/" ${FPPHOME}/media/settings

# Restart FPP daemon
fppd_start

