#!/bin/bash
################################################################################
# UserCallbackHook.sh - Callback script to allow hooking into FPP system scripts
################################################################################

case $1 in
	preStart)
		######################################################################
		# preStart is executed before plugin preStarts and before fppd startup
		######################################################################
		# put your commands here
		;;

	postStart)
		######################################################################
		# postStart is executed after fppd and plugin postStarts are run
		######################################################################
		# put your commands here
		;;

	preStop)
		######################################################################
		# preStop is executed before plugin preStop and run and fppd is stopped
		######################################################################
		# put your commands here
		;;

	postStop)
		######################################################################
		# postStop is executed after the plugin postStops are fppd shutdown
		######################################################################
		# put your commands here
		;;

esac

