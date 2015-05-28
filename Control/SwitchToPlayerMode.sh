#!/bin/sh
###########################################################
# SwitchToPlayerMode.sh - Switch a running FPP instance   #
#                         to player mode and restart FPPD #
#                                                         #
# NOTE: Any running playlist will be stopped.             #
###########################################################


# Stop FPP daemon
fppd_stop

# Switch config to player mode
sed -i "s/fppMode.*=.*/fppMode = player/" ${FPPHOME}/media/settings

# Restart FPP daemon
fppd_start

