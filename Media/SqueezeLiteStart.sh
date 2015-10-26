#!/bin/sh
##############################################################################
# SqueezeLiteStart.sh - Start squeezelite to turn FPP into a Squeeze player
##############################################################################
# To use this script with FPP v0.4.0, you must first install
# squeezelite-armv6hf. Login to the Pi via SSH and run the following commands:
#
# cd /usr/bin
# sudo wget http://squeezelite-downloads.googlecode.com/git/squeezelite-armv6hf
# sudo chmod 755 squeezelite-armv6hf
#
#---------
#
# Once you have installed squeezelite, edit the 'SERVER' variable below to
# contain the IP address or hostname of your LMS server.
#
##############################################################################
# Script Actions - These are automatically executed in FPP v1.0 and higher
# InstallAction: sudo wget -q -O /usr/bin/squeezelite-armv6hf http://squeezelite-downloads.googlecode.com/git/squeezelite-armv6hf
# InstallAction: sudo chmod 755 /usr/bin/squeezelite-armv6hf
##############################################################################

##############################################################################
# To connect to a specific LMS server, fill in the server's IP address
# in the following SERVER variable.  ie,  SERVER="192.168.1.100"
##############################################################################
SERVER=""

##############################################################################
# Use the hostname configured via the FPP Web UI
##############################################################################
HOSTNAME=$(hostname)

##############################################################################
# To not set the hostname and instead let the identifier be set on the LMS
# server, uncomment the following line to clear the HOSTNAME variable
#
# HOSTNAME=""

#############################################################################

# Set the soundcard
SL_SOUNDCARD="sysdefault:CARD=ALSA"
#SL_SOUNDCARD="front:CARD=MicroII,DEV=0"

# Uncomment the next line if you want squeezelite to start playing on startup. BE AWARE: If you use this, you
# should also uncomment and fill-in SERVER (see above). Otherwise this will not work.
#SL_AUTO_PLAY="Yes"

# Squeezebox server port for sending play and power off commands
SB_SERVER_CLI_PORT="9090"



if [ "x${SERVER}" != "x" ]
then
	SB_SERVER="-s ${SERVER}"
fi

if [ "x${HOSTNAME}" != "x" ]
then
	SL_HOSTNAME="-n ${HOSTNAME}"
fi

OTHER_ARGS=""

# add souncard setting if set
if [ ! -z "$SL_SOUNDCARD" ]
then
	OTHER_ARGS="${OTHER_ARGS} -o ${SL_SOUNDCARD}"    
fi


sudo /usr/bin/squeezelite-armv6hf -z ${SB_SERVER} ${SL_HOSTNAME} ${OTHER_ARGS}


#
# Function for telling the player to start playing at a certain volume (optional)
#
#play 40
#
do_play () {
    # This function only works if the Squeezebox server IP is set
    if  [ ! -z "$SERVER" ]; then
      echo "Sending play command to Squeezebox server"
      printf "$HOSTNAME play\nexit\n" | nc $SERVER $SB_SERVER_CLI_PORT > /dev/null
    else
      echo "The IP address of the Squeezebox server is not set (variable: SERVER should be set). This is needed for the play function."
    fi
}


if [ ! -z "$SL_AUTO_PLAY" ] && [ "$SL_AUTO_PLAY" = "Yes" ]; then
  if  [ ! -z "$SERVER" ]; then
    echo "Wait until player is connected to Squeezebox server before sending play command"
    for i in $(seq 1 10)
    do
      PLAYERCONNECTED=$(printf "$SL_NAME connected ?\nexit\n" | nc ${SERVER} ${SB_SERVER_CLI_PORT}  | tr -s ' '| cut -d ' ' -f3)
      if [ "$PLAYERCONNECTED" = "1" ]
      then
        echo "Player connected to Squeezebox server after $i seconds"
        break
      fi
      echo "Not connected after $i seconds..."
      sleep 1
    done
    if [ "$PLAYERCONNECTED" = "1" ]
    then
      do_play
    else
      echo "Could not send play command to player $HOSTNAME on Squeezebox server $SERVER"
    fi
  fi
fi


