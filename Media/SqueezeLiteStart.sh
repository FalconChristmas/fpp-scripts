#!/bin/sh
##############################################################################
# SqueezeLiteStart.sh - Start squeezelite to turn FPP into a Squeeze player
##############################################################################
# To use this script with FPP v7.0, you must first install
# squeezelite. Login to the Pi via SSH and run the following commands:
#
# sudo apt-get install squeezelite
# sudo service squeezelite stop
# sudo update-rc.d squeezelite disable
#
#---------
#
# Once you have installed squeezelite, edit the 'SERVER' variable below to
# contain the IP address or hostname of your LMS server.
#
##############################################################################
# Script Actions - These are automatically executed in FPP v1.0 and higher
# InstallAction: sudo apt-get install squeezelite
# InstallAction: sudo service squeezelite stop
# InstallAction: sudo update-rc.d squeezelite disable
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

# Any command that need to be run instead of normal startup (only supports pause at this time)
COMMAND=""


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


sudo /usr/bin/squeezelite -z ${SB_SERVER} ${SL_HOSTNAME} ${OTHER_ARGS}


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

# Toggle pause/play
do_pause () {
    # This function only works if the Squeezebox server IP is set
    if  [ ! -z "$SERVER" ]; then
       echo "Sending pause command to Squeezebox server"
       printf "$HOSTNAME pause\nexit\n" | nc $SERVER $SB_SERVER_CLI_PORT > /dev/null
    else
       echo "The IP address of the Squeezebox server is not set (variable: SERVER should be set). This is needed for the pause function."
    fi
}				   
if [ ! -z "$SL_AUTO_PLAY" ] && [ "$SL_AUTO_PLAY" = "Yes" ]; then
  if  [ ! -z "$SERVER" ]; then
    echo "Wait until player is connected to Squeezebox server before sending play command"
    for i in $(seq 1 10)
    do
      PLAYERCONNECTED=$(printf "$HOSTNAME connected ?\nexit\n" | nc ${SERVER} ${SB_SERVER_CLI_PORT}  | tr -s ' '| cut -d ' ' -f3)
      if [ "$PLAYERCONNECTED" = "1" ]
      then
        echo "$HOSTNAME player connected to Squeezebox server after $i seconds"
        break
      fi
      echo "Not connected after $i seconds..."
      sleep 1
    done
    if [ "$PLAYERCONNECTED" = "1" ]; then
      if  [ ! -z "$COMMAND" ]; then
        if  [ "$COMMAND" -eq "pause" ]; then
          do_pause
        fi
      else
        do_play
      fi	
    else
      echo "Could not send play command to player $HOSTNAME on Squeezebox server $SERVER"
    fi
  fi
fi


