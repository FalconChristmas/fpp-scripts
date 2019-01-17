#!/bin/sh
##############################################################################
# Enable_HiFiBerry.sh - Script for enabling support for the HiFiBerry add-on #
#                       cards for the Raspberry Pi                           #
##############################################################################
# Uncomment one of the following "HIFIBERRY=" lines to specify which
# HiFiBerry you want to configure.  Comment out the dacplus line if you are
# not using a HiFiBerry DAC+ standard/pro.
##############################################################################
# DAC/DAC+ Light/DAC Zero/MiniAmp/BeoCreate/DAC+ DSP
#HIFIBERRY=dac
# DAC+ standard/pro/Amp2
HIFIBERRY=dacplus
# Digi/Digi+
#HIFIBERRY=digi
# Amp+ (not Amp2)
#HIFIBERRY=amp
##############################################################################

# Sanity Check the model
if [ "x${HIFIBERRY}" = "x" ]
then
	echo "ERROR: Unknown HiFiBerry model"
	exit
fi

IMGVER=$(head -1 /etc/fpp/rfs_version | cut -c1-2)
if [ "x${IMGVER}" = "xv1" ]
then
	# pull in the updates so we can get the newer kernel needed by the HiFiBerry
	apt-get -y update
	apt-get -y upgrade
fi

# Disable the onboard soundcard
sed -i "/snd-bcm2835/d" /etc/modules

# Enable some new modules
cat <<-EOF >> /etc/modules
bcm2708_dmaengine
snd_soc_pcm512x
snd_soc_hifiberry_${HIFIBERRY}
snd_soc_bcm2708_i2s
EOF

# Remove any pre-existing HiFiBerry boot config entry
sed -i "/^dtoverlay=hifiberry/d" /boot/config.txt

# Enable the HiFiBerry
cat <<-EOF >> /boot/config.txt
dtoverlay=hifiberry-${HIFIBERRY}
dtparam=i2s=on
EOF

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

