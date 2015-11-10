#!/bin/sh
##############################################################################
# Enable_HiFiBerry.sh - Script for enabling support for the HiFiBerry add-on #
#                       cards for the Raspberry Pi                           #
##############################################################################
# Uncomment one of the following "HIFIBERRY=" lines to specify which
# HiFiBerry you want to configure.  Comment out the dacplus line if you are
# not using a HiFiBerry DAC+ standard/pro.
##############################################################################
# DAC/DAC+ Light
#HIFIBERRY=dac
# DAC+ standard/pro
HIFIBERRY=dacplus
# Digi/Digi+
#HIFIBERRY=digi
# Amp/Amp+
#HIFIBERRY=amp
##############################################################################

# Sanity Check the model
if [ "x${HIFIBERRY}" = "x" ]
then
	echo "ERROR: Unknown HiFiBerry model"
	exit
fi

# pull in the updates so we can get the newer kernel needed by the HiFiBerry
apt-get -y update
apt-get -y upgrade

# Disable the onboard soundcard
sed -i -e "s/^snd-bcm2835/#snd-bcm2835/" /etc/modules

# Remove any pre-existing HiFiBerry boot config entry
sed -i "/^dtoverlay=hifiberry/d" /boot/config.txt

# Enable the HiFiBerry
echo "dtoverlay=hifiberry-${HIFIBERRY}" >> /boot/config.txt

# Configure ALSA
cat <<-EOF > /root/.asoundrc
pcm.!default  {
  type hw
  card 0
}
ctl.!default {
  type hw
  card 0
}
EOF

# Reboot for the changes to take effect
shutdown -r now

