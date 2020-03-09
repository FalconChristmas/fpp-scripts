#!/bin/bash
#############################################################################
# This script is intended to fix older FPP releases which are no longer able
# to pull in FPP updates from github using the 'Manual Update' button in FPP
# due to a change in a response from the github.com web servers.  Due to the
# change, the FPP update script does not think the web server is accessible
# and returns the follwoing error message:
#
#            "Can not access github, unable to pull git updates"
#
# This script will manually force a git update without checking the web
# server status.  This will pull in a new updated version of the FPP update
# script which works with the new and old github web server configs.  This
# script does not need to be run more than once.
#
# The script will also switch the user to the latest v1.x, v2.x, or v3.x
# branch of code depending on which release of FPP the script is run on.
#############################################################################


cd /opt/fpp/

echo "Running manual git pull to pull in bug fix for FPP update code."
sudo git pull

MAJORVER=$(git describe | cut -c1)
LATEST=""

echo "Found FPP Major Version: v${MAJORVER}.x"

if [ "x${MAJORVER}" = "x1" -o "x${MAJORVER}" = "x2" -o "x${MAJORVER}" = "x3" ]
then
    LATEST=$(git branch -a | grep "remotes/origin/v${MAJORVER}" | sed -e "s#.*remotes/origin/v${MAJORVER}.##" | sort -n | tail -1)
    LATEST="v${MAJORVER}.${LATEST}"
fi

if [ "x${LATEST}" != "x" ]
then
    echo "Latest branch for v${MAJORVER}.x is ${LATEST}."
	echo "Switching branches to ${LATEST}."
    sudo git checkout ${LATEST}
fi

echo "Pulling in latest updates."
sudo git pull

grep -q "grep -i" /opt/fpp/scripts/git_pull
if [ $? != 0 ]
then
    echo "</pre><b>Error applying update, please copy and paste the text above into a post on<br>FalconChristmas.com so that we can determine what issue prevented the<br>update from occurring properly.</b><pre>"
else
    echo "</pre><b>Code updated successfully.</b><br><br><b>You will now be directed to FPP's normal update script to complete the update.<br><br>Redirecting in 10 seconds....<br><pre>"
    sleep 1; echo "9"
    sleep 1; echo "8"
    sleep 1; echo "7"
    sleep 1; echo "6"
    sleep 1; echo "5"
    sleep 1; echo "4"
    sleep 1; echo "3"
    sleep 1; echo "2"
    sleep 1; echo "1"
    sleep 1; echo "Redirecting......</b>"
    sleep 1
    echo

    echo "</pre><script>location.href='manualUpdate.php';</script><pre>"
fi

