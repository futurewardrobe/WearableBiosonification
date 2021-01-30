#!/usr/bin/env bash

user=$(logname)
temp_dir=/tmp/wbs
#sketchbook=/home/$user/sketchbook

echo "installing all parts of Wearable Biosonification"

echo ""
echo "updating system"
sudo apt update && sudo apt -y upgrade

echo ""
echo "installing git and puredata"
sudo apt install -y git puredata pd-iemnet pd-osc

echo ""
if ! command -v processing &> /dev/null; then
    echo "installing processing..."
    curl https://processing.org/download/install-arm.sh | sudo sh
else
    echo "processing is already installed!"
fi

echo ""
mkdir -p $temp_dir
libraries=/home/$user/sketchbook/libraries
mkdir -p $libraries

if [ ! -d $libraries/controlP5 ]; then
    echo "installing controlP5 library..."
    wget https://github.com/sojamo/controlp5/releases/download/v2.2.5/controlP5-2.2.5.zip -P $temp_dir
    unzip $temp_dir/controlP5-2.2.5.zip -d $temp_dir
    mv $temp_dir/controlP5 $libraries
else
    echo "controlP5 is already installed!"
fi

if [ ! -d $libraries/oscP5 ]; then
    echo "installing oscP5 library..."
    wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/oscp5/oscP5-0.9.9.zip -P $temp_dir
    unzip $temp_dir/oscP5-0.9.9.zip -d $temp_dir
    mv $temp_dir/oscP5 $libraries
else
    echo "oscP5 is already installed!"
fi

echo ""
if [ ! -d /home/$user/wbs/.git ]; then
    echo "cloning wearable biosonification repository"
    git clone https://github.com/futurewardrobe/WearableBiosonification.git /home/$user/wbs
else
    echo "repository already exists, pulling latest version..."
    git -C /home/$user/wbs/ pull
fi

echo ""
echo "setting up Wearbale Biosonification network"
read -p "WiFi SSID: " ssid
read -p "WiFi password: " password

echo "creating config files..."
find_ssid='s/ssid="'
find_pwd='s/psk="'
wpa_path=/etc/wpa_supplicant
sudo mv $wpa_path/wpa_supplicant.conf $wpa_path/wpa_supplicant.conf.bak
cat /home/$user/wbs/rpi/wpa_supplicant.conf | sed "$find_ssid/&$ssid/" | sed "$find_pwd/&$password/" > $temp_dir/wpa_supplicant.conf
sudo mv $temp_dir/wpa_supplicant.conf $wpa_path/

curr_ip=`ifconfig wlan0 | awk '/inet /{print substr($2,0)}'`
curr_router=`ip r | awk '/default via /{print substr($3,0)}'`
echo $curr_ip
echo $curr_router
sudo mv /etc/dhcpcd.conf /etc/dhcpcd.conf.bak
cat /home/$user/wbs/rpi/dhcpcd.conf | sed "s/static ip_address=/&$curr_ip/" | sed "s/static routers=/&$curr_router/" \
    > $temp_dir/dhcpcd.conf
sudo mv $temp_dir/dhcpcd.conf /etc/dhcpcd.conf
echo ""
echo "ENTER THIS IP ADDRESS IN THE ARDUINO SKETCH: $curr_ip"

echo ""
echo "creating unit files..."
cmd="\/usr\/local\/bin\/processing-java --sketch=\/home\/$user\/wbs\/processing\/biodata_sensor --run"
xauth="XAUTHORITY=\/home\/$user\/.Xauthority"
env='Environment="'
cat /home/$user/wbs/rpi/wbs_processing.service |\
    sed "s/ExecStart=/&$cmd/" |\
    sed "s/User=/&$user/" |\
    sed "0, /$env/s//&$xauth/" > $temp_dir/wbs_processing.service
sudo mv $temp_dir/wbs_processing.service /etc/systemd/system/wbs_processing.service

cmd="\/usr\/bin\/puredata -nogui -nomidi -noadc -alsa -audiooutdev 3 \/home\/$user\/wbs\/PD\/_main.pd"
xauth="XAUTHORITY=\/home\/$user\/.Xauthority"
env='Environment="'
cat /home/$user/wbs/rpi/wbs_puredata.service |\
    sed "s/ExecStart=/&$cmd/" |\
    sed "s/User=/&$user/" |\
    sed "0, /$env/s//&$xauth/" > $temp_dir/wbs_puredata.service
sudo mv $temp_dir/wbs_puredata.service /etc/systemd/system/wbs_puredata.service

sudo systemctl daemon-reload
sudo systemctl enable wbs_processing.service
sudo systemctl enable wbs_puredata.service
    








