#/bin/sh

pushd /home/fpp/media/upload/

PLATFORM=$(cat /etc/fpp/platform)

echo "Platform: $PLATFORM"

TYPE="BBB"

if [ "x${PLATFORM}" = "xRaspberry Pi" ]
then
	TYPE="Pi"
fi

echo "Image Type: $TYPE"

echo "Download the image"

LOCATION=$(curl -s https://api.github.com/repos/FalconChristmas/fpp/releases \
| grep "browser_download_url.*$TYPE-\?v\?[0-9].[0-9].\?[0-9]\?.fppos" -m 1 \
| cut -d ":" -f 2,3 \
| tr -d \" \
| tr -d [:space:] \
)

echo $LOCATION

if [ -z "$LOCATION" ]
then
      echo "\$LOCATION is empty"
      exit 1
fi

IFS='/' read -a fn_array <<< "${LOCATION}"

FPPOSNAME="${fn_array[-1]}"

echo "File Name: $FPPOSNAME"
echo "Using Image URL Link: $LOCATION"

echo "Downloading...."

wget $LOCATION

echo "Download Complete"

#echo "Installing FPPOS File"
#wget "http://localhost/upgradeOS.php?wrapped=1&os=$FPPOSNAME"
#echo "Installation Complete"
