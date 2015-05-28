#!/bin/sh
###########################################################
# SwitchToMasterMode.sh - Switch a running FPP instance   #
#                         to master mode and restart FPPD #
#                                                         #
# NOTE: Any running playlist will be stopped.             #
###########################################################


# Stop FPP daemon
fppd_stop

# Switch config to master mode
sed -i "s/fppMode.*=.*/fppMode = master/" ${FPPHOME}/media/settings

# Restart FPP daemon
fppd_start

