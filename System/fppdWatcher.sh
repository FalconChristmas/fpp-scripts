#!/bin/bash
#############################################################################
# fppdWatcher.sh - Watch for the fppd process not running and restart
#############################################################################

# Check to see if this watcher script is already running
BASE=$(basename $0)
OTHERPID=$(ps -edaf | grep ${BASE} | grep -v grep | grep -v " $$ " | awk '{print $2}')
if [ -n ${OTHERPID} ]
then
	echo "The ${BASE} script is already running as PID ${OTHERPID}"
	exit
fi

# Loop forever
while /bin/true
do
	# Check for the fppd process running
	case "$(ps -eadf | grep fppd | grep -v fppdWatcher | grep -v grep | awk '{print $2}' | wc -w)" in
		0)	# No PID found, see if we need to restart
			sudo /opt/fpp/scripts/fppd_start
			;;
		*)	# At least one pid found, don't need to restart
			;;
	esac

	sleep 30
done
