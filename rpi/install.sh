#!/usr/bin/env bash

user=$(logname)
temp_dir=/tmp/wbs
sketchbook=/home/$user/sketchbook

echo "installing all parts of Wearable Biosonification"

echo ""
echo "updating system"
apt update && apt upgrade

echo ""
echo "installing git and puredata"
apt install -y git puredata

echo ""
if ! command -v processing &> /dev/null; then
    echo "installing processing..."
    curl https://processing.org/download/install-arm.sh | sudo sh
else
    echo "processing is already installed!"
fi

echo ""
mkdir -p $temp_dir
libraries=$sketchbook/libraries
mkdir -p $libraries

if [ ! -d $libraries/oscP5 ]; then
    echo "installing oscP5 library..."
    wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/oscp5/oscP5-0.9.9.zip -P $temp_dir
    unzip ${temp_dir}/oscP5-0.9.9.zip -d $temp_dir
    mv $temp_dir/oscP5 $libraries
else
    echo "oscP5 is already installed!"
fi

echo ""
echo "cloning wearable biosonification repository"
git clone https://github.com/futurewardrobe/WearableBiosonification.git /home/$user/wbs
