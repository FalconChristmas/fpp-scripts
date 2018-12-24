#!/bin/sh
#############################################################################
# UpdateGitRepoOrigin.sh - Used to point a local git clone at another       #
#                          repository location such as pointing a Remote    #
#                          FPP instance at the Master's cloned repo.        #
#############################################################################

# Put the new origin URL here.  To point a Remote FPP's
# instance at the Master FPP's local repository, you should
# enter a URL such as http://192.168.1.101/git/ where 192.168.1.101 is
# the IP address of the Master FPP server.
ORIGIN="https://github.com/FalconChristmas/fpp.git"

# This is the default origin URL and can be used to revert and point a system
# back at the main FPP repository on github.com.  Uncomment the following
# line and re-run the script to revert the origin URL.
#ORIGIN="https://github.com/FalconChristmas/fpp.git"

cd /opt/fpp/
sudo git remote set-url origin ${ORIGIN}

