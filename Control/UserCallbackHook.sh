#!/bin/bash
################################################################################
# UserCallbackHook.sh
#
# This is an optional script you can use to run your own commands at
# specific moments in FPP's startup and shutdown process, without needing
# to write a full plugin. FPP automatically looks for this file and, if it
# exists, runs it and tells it which moment ("boot", "preStart", etc.) is
# currently happening by passing that word in as the first argument ($1).
#
# The "case" statement below sorts out which moment is which. You don't
# need to touch anything outside of the section that matches the moment
# you care about - just add your own shell commands in the spot marked
# "put your commands here" underneath the moment you want to react to.
# It is completely fine to leave a section empty (or leave the whole file
# unedited) if you don't need to do anything at that moment.
#
# IMPORTANT: FPP waits for this script to completely finish running before
# it moves on to its next step - for example, before it finishes booting,
# before fppd finishes starting, or before fppd finishes stopping. If a
# command you add here takes a long time, hangs, or never finishes (e.g.
# waiting on a network connection that isn't there yet), it will delay -
# or completely stall - FPP's startup or shutdown. If you need to run
# something that could take a while, either give it a way to time out and
# give up on its own, or add a "&" to the end of that command so it runs
# in the background instead of making FPP wait for it.
################################################################################

case $1 in
	boot)
		######################################################################
		# boot
		#
		# Runs one time, when the device first powers on / boots up - this
		# happens well before FPP has set up networking (WiFi/Ethernet), so
		# don't rely on network access being available yet in this section.
		# This is a good place for very early setup that has nothing to do
		# with the network, e.g. hardware initialization.
		######################################################################
		# put your commands here
		;;

	preStart)
		######################################################################
		# preStart
		#
		# Runs every time FPP's player service (called "fppd") is about to
		# start up - this includes the very first time it starts after
		# booting, as well as any time it is restarted later (for example,
		# if you restart it manually or from the FPP web interface).
		# This section runs before fppd itself starts, and before any
		# installed plugins run their own "preStart" steps. This is a good
		# place to do preparation work that fppd needs to have ready before
		# it starts running.
		######################################################################
		# put your commands here
		;;

	postStart)
		######################################################################
		# postStart
		#
		# Runs every time fppd has finished starting up - this section runs
		# after fppd itself has started, and after any installed plugins
		# have finished their own "postStart" steps. This is a good place
		# to do things that only make sense once FPP is fully up and
		# running.
		######################################################################
		# put your commands here
		;;

	preStop)
		######################################################################
		# preStop
		#
		# Runs every time fppd is about to stop - this includes shutting
		# down, rebooting, and any time it is restarted manually or from the
		# FPP web interface. This section runs before any installed plugins
		# run their own "preStop" steps, and before fppd has actually
		# stopped. This is a good place to do cleanup work that needs FPP to
		# still be running.
		######################################################################
		# put your commands here
		;;

	postStop)
		######################################################################
		# postStop
		#
		# Runs every time after fppd has fully stopped - this section runs
		# after any installed plugins have finished their own "postStop"
		# steps. This is a good place for final cleanup once everything has
		# shut down.
		######################################################################
		# put your commands here
		;;

esac

