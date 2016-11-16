#!/bin/sh

PLATFORM=$(cat /etc/fpp/platform)

if [ "x${PLATFORM}" != "xRaspberry Pi" ]
then
	echo "ERROR: This script only works on the Raspberry Pi SD image"
	exit
fi

echo "Creating /etc/init.d/overlayroot init script"
cat > /etc/init.d/overlayroot <<-EOF
#!/bin/sh
### BEGIN INIT INFO
# Provides:          overlayroot
# Required-Start:    \$hostname
# Required-Stop:
# Should-Start:
# Default-Start:     S
# Default-Stop:
# Short-Description: FPP OS image read-only root initialization
# Description:       FPP OS image read-only root initialization
### END INIT INFO
#########################################################################
# /etc/init.d/overlayroot: setup overlayfs on read-only root
#########################################################################


export PATH=/bin:/usr/bin:/usr/sbin:/sbin

mount -t tmpfs tmpfs /etc.rw

mkdir /etc.rw/work
mkdir /etc.rw/upper

mount -t overlay -o lowerdir=/etc.ro,upperdir=/etc.rw/upper,workdir=/etc.rw/work overlay /etc

EOF

echo "Activating /etc/init.d/overlayroot init script"
update-rc.d overlayroot enable

echo "Adding 'fastboot ro' to kernel boot arguments"
sed -i -e "s/ fastboot ro$//" /boot/cmdline.txt
sed -i -e "s/$/ fastboot ro/" /boot/cmdline.txt

echo "Making /etc.ro and /etc.rw directories for overlay filesystem"
mkdir /etc.ro
mkdir /etc.rw

echo "Copying contents of /etc to /etc.ro for underlay"
rsync -av /etc/ /etc.ro/

echo "============================================================================="
echo "Setup complete, you will need to reboot the Pi for the changes to take effect"
echo "============================================================================="

