#!/bin/sh
#############################################################################
# This script is designed to reverse the effects of ConvertPiRootToReadOnly.sh
# to convert a Read-Only Pi back to Read-Write.
#############################################################################

PLATFORM=$(cat /etc/fpp/platform)

if [ "x${PLATFORM}" != "xRaspberry Pi" ]
then
	echo "ERROR: This script only works on the Raspberry Pi SD image"
	exit
fi

# Actions needed
#
# remount root and boot read-write
# remove /etc/init.d/overlayroot and links via update-rc.d
# remove 'fastboot ro' from /boot/cmdline.txt
# change 'ro,defaults' in /etc/fstab to 'defaults'
# rm -f /home/fpp/media/scripts/ConvertReadOnlyPitoRW.sh

echo "Remounting / and /boot Read-Write for updating"
sudo mount -o remount,rw /
sudo mount -o remount,rw /boot

echo "Unmounting /etc/ overlay filesystem"
sudo umount /etc

echo "Removing overlayroot script and links"
sudo rm -f /etc/init.d/overlayroot
sudo update-rc.d overlayroot remove

echo "Cleaning up old /etc.ro and /etc.rw directories"
sudo umount /etc.rw
sudo rm -rf /etc.rw /etc.ro

echo "Cleaning up /boot/cmdline.txt"
sudo sed -i -e "s/ fastboot ro$//" /boot/cmdline.txt

echo "Updating fstab to mount read-write"
sudo sed -i -e "s/vfat.*ro,defaults/vfat    defaults/" /etc/fstab
sudo sed -i -e "s/ext4.*ro,defaults/ext4    defaults/" /etc/fstab

echo "============================================================================="
echo "Setup complete, you will need to reboot the Pi for the changes to take effect"
echo "This script will self-delete to prevent re-running."
echo "============================================================================="

sudo rm -f /home/fpp/media/scripts/ConvertReadOnlyPitoRW.sh

