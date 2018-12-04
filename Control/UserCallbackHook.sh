#!/bin/bash
################################################################################
# UserCallbackHook.sh - Callback script to allow hooking into FPP system scripts
################################################################################

case $1 in
	boot)
		######################################################################
		# boot is executed at OS boot time before the network is initialized.
		# This section runs once per system boot.
		######################################################################
		# put your commands here
		;;

	preStart)
		######################################################################
		# preStart is executed before plugin preStarts and before fppd startup.
		# This section runs every time fppd is started
		######################################################################
		# put your commands here
		;;

	postStart)
		######################################################################
		# postStart is executed after fppd and plugin postStarts are run.
		# This section runs every time fppd is started
		######################################################################
		# put your commands here
		;;

	preStop)
		######################################################################
		# preStop is executed before plugin preStop and run and fppd is stopped.
		# This section runs every time fppd is started
		######################################################################
		# put your commands here
		;;

	postStop)
		######################################################################
		# postStop is executed after the plugin postStops are fppd shutdown.
		# This section runs every time fppd is started
		######################################################################
		# put your commands here
		;;

esac

