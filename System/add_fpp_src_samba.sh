#!/bin/bash

echo "Adding src share to /etc/samba/smb.conf"

echo -e "\n[fpp_src]\n  comment = fpp src Share\n  path = /opt/fpp\n  writeable = Yes\n guest ok = no" >> /etc/samba/smb.conf
echo -e "  create mask = 0777\n  directory mask = 0777\n  browseable = Yes\n  public = yes\n  force user = root" >> /etc/samba/smb.conf

echo "restarting smbd"
service smbd status | grep 'active (running)' > /dev/null 2>&1

if [ $? != 0 ]
then
        sudo service smbd restart > /dev/null
fi

echo "done"