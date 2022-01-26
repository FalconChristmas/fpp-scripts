#!/bin/bash
##############################################################################
# SetupDPI.sh - Script to install DPI device tree overlay for RPi
##############################################################################
# DPI can be enabled on GPIO pins 0 - 27.
# However, this conflicts with other functions (on-board sound, I2C, SPI, etc)
# Edit vars below or use command line args to selectively configure DPI pins.
# NOTE: user is responsible for resolving any GPIO pin conflicts.
##############################################################################
#set -x  #uncomment for debug

# File names:
CONFIG=/boot/config.txt
CONFIG_BK=${CONFIG/.txt/-BK.txt}
OVERLAYS=/boot/overlays
OVLNAME=dpi24_masked
#DTS_FILE=/tmp/${OVLNAME}.dts
#DTBO_FILE=${DTS_FILE/.dts/.dtbo}

# Get tools:
#sudo apt install dtc  #overlay compiler
if which gpio; then
  echo "WiringPi (test tool) already installed."
else
  sudo apt install wiringpi  #useful test utility
fi

# Get GPIO pin list from command line or edit below:
DPI_PINS=${1:-/*0 1 2 3*/ 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27}  #if none specified, set use all pins

# Timing:
# Uses 2.4MHz px clock (gives 3 px/bit for WS281X data render) with 4:3 aspect.
# Adjust other params as desired.
FPS=${2:-20}
case ${FPS} in
    20)  #20 FPS (1666 nodes/fr):
        TIMING="392 0 0 1 0  294 0 4 3 4  0 0 0  20 0 2400000 1"
        MAXPX=1600
        ;;
    40)  #40 FPS (833 nodes/fr):
        TIMING="278 0 0 1 0  209 0 2 2 2  0 0 0  40 0 2400000 1"
        MAXPX=800
        ;;
    30)  #30 FPS (1111 nodes/fr):
        TIMING="326 0 0 1 0  244 0 0 1 0  0 0 0  30 0 2400000 1"
        MAXPX=1100
        ;;
    15)  #15 FPS (2222 nodes/fr):
        TIMING="464 0 0 1 0  348 0 1 1 0  0 0 0  15 0 2400000 1"
        MAXPX=2222
        ;;
    18.5)  #18.5 FPS (1800 nodes/fr):
        TIMING="416 0 0 1 0  310 0 1 1 0  0 0 0  18 0 2400000 1"
        MAXPX=1800
        ;;
    *)
        echo "Error: unhandled FPS: '${FPS}'; choices are: 15, 18.5, 20, 30, 40"
        exit 1
        ;;
esac

# Generate DTS file:
# Uses a slightly modified version of dpi24-overlay.dts
# from https://github.com/raspberrypi/linux/tree/rpi-5.4.y/arch/arm/boot/dts/overlays
# or https://github.com/raspberrypi/linux/tree/rpi-4.1.y/arch/arm/boot/dts/overlays
# For more info, see:
# https://www.raspberrypi.org/documentation/configuration/device-tree.md
# https://github.com/raspberrypi/linux/tree/rpi-5.4.y/arch/arm/boot/dts/overlays/dpi24-ovrlay.dts
# https://www.kernel.org/doc/Documentation/devicetree/overlay-notes.txt
# https://raspberrypi.stackexchange.com/questions/62903/how-to-detect-a-device-tree-overlay-at-run-time
WHEN=`date +"%D %T"`

cat <<DPI_EOF > /tmp/${OVLNAME}.dts
/dts-v1/;
/plugin/;
/{
	compatible = "brcm,bcm2835";

//hang pinctrl ref on a platform device node:
//there is no DPI driver module, but leds will do
	fragment@0 {
		target = <&fb>;
		__overlay__ {
			pinctrl-names = "default";
			pinctrl-0 = <&dpi24_pins>;
		};
	};

	fragment@1 {
		target = <&vc4>;
		__overlay__ {
			pinctrl-names = "default";
			pinctrl-0 = <&dpi24_pins>;
		};
	};

	fragment@2 {
		target = <&gpio>;
		__overlay__ {
			dpi24_pins: dpi24_pins {
//generated ${WHEN}
//GPIO 0 - 3 !needed for WS281X (self-clocking), but might be useful for other purposes
//TODO: add param (__overrides__) for the above?
//				brcm,pins = </*0 1 2 3*/ 4 5 6 7 8 9 10 11
//					     12 13 14 15 16 17 18 19 20
//					     21 22 23 24 25 26 27>;
				brcm,pins = <${DPI_PINS}>;
                brcm,function = <6>; /* alt2 */
				brcm,pull = <0>; /* no pull-up*/
			};
		};
    };
};
DPI_EOF

# Compile and install:
echo "Setting up GPIO pins ${DPI_PINS} for DPI at ${FPS} FPS ..."
echo "NOTE: these pins won't work with other functions; please check for conflicts."

dtc -I dts -O dtb -o /tmp/${OVLNAME}.dtbo /tmp/${OVLNAME}.dts
sudo cp /tmp/${OVLNAME}.dtbo ${OVERLAYS}
echo "DPI overlay installed."

# Remove (comment out) old DPI-related settings:
#set -x
sudo cp ${CONFIG} ${CONFIG_BK}  #make a backup before changing

# Append DPI-related settings or only DPI timing in config file:
if grep -q "^dtoverlay=${OVLNAME}" "${CONFIG}"; then
  echo "DPI settings already found in ${CONFIG}, only updating timing."
#kludge: change sed delim to avoid "unknown option to `s'" error
  sudo sed -i "s!^\s*dtoverlay\s*=\s*dpi.*!#updated ${WHEN} pins ${DPI_PINS}\n#&\ndtoverlay=${OVLNAME}!g" ${CONFIG}
  sudo sed -i "s!^\s*\(dpi\|hdmi\)_timings\s*=.*!#updated ${WHEN} ${FPS} fps\n#&\ndpi_timings=${TIMING}!g" ${CONFIG}
#TODO: other entries like hdmi, overscan, etc?
  echo "old list of DPI pins:"
  hexdump -x /sys/firmware/devicetree/base/soc/gpio@7e200000/dpi24_pins/brcm,pins 
else
#no worky: sudo cat <<CFG_EOF >> ${CONFIG}
  sudo tee -a ${CONFIG} > /dev/null << CFG_EOF

######################################
# DPI entries added ${WHEN}
######################################
dtoverlay=${OVLNAME} #pins ${DPI_PINS}
# DPI: invert clock (data on falling edge), data valid, RGB order, 24-bit 888
dpi_output_format=0x17
dpi_group=2
dpi_mode=87
dpi_timings=${TIMING} #${FPS} fps
# Other settings (uncomment if needed):
#gpu_mem=128
# Avoid conflicts:
#dtparam=i2c_arm=off
#dtparam=spi=off
#dtparam=i2s=on
#dtparam=audio=off
# Enable second fb device:
#max_framebuffers=2
# Set DPI to display on fb1, leave fb0 for HDMI or console:
enable_dpi_lcd=1
display_default_lcd=1
#disable_touchscreen=1
# Force display if no monitor detected:
hdmi_force_hotplug=1
hdmi_ignore_edid_audio=1
# Turn off border, overscan:
disable_overscan=1
overscan_left=0
overscan_right=0
overscan_top=0
overscan_bottom=0
# Set framebuffer size:
framebuffer_depth=32
#framebuffer_ignore_alpha=1
#framebuffer_width=
#framebuffer_height=

#eof
CFG_EOF
  echo "DPI entries added to ${CONFIG}."
fi

echo
echo "Done. Reboot for changes to take effect."
# shutdown -r now  #reboot for the changes to take effect
echo "To verify (after reboot), use one of these commands:"
echo "gpio readall  #should show 'ALT2' for DPI pins"
echo "sudo ls -R /sys | grep dpi24_masked"
echo "hexdump -C /sys/firmware/devicetree/base/soc/gpio@7e200000/dpi24_pins/brcm,pins  #shows list of pins (uint32) enabled for DPI"

#eof
