#!/bin/bash

#############################################################################
# Create a blacklist file to disable onboard WiFi.
# NOTE: Reboot after running!
#############################################################################

cat <<_EOF | sudo tee /etc/modprobe.d/wifi-blacklist.conf >/dev/null
blacklist brcmfmac
blacklist brcmutil
blacklist btbcm
blacklist hci_uart
_EOF
