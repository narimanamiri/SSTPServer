#!/bin/bash

# Update package list
sudo apt-get update

# Install required packages
sudo apt-get install build-essential libssl-dev libwrap0-dev libpam0g-dev libreadline-dev libnl-route-3-dev -y

# Download SoftEther VPN server
wget https://www.softether-download.com/files/softether/v4.38-9760-beta-2022.01.01-tree/Linux/SoftEther_VPN_Server/64bit_-_Intel_x64_or_AMD64/softether-vpnserver-v4.38-9760-beta-2022.01.01-linux-x64-64bit.tar.gz

# Extract and install SoftEther VPN server
tar xzvf softether-vpnserver-v4.38-9760-beta-2022.01.01-linux-x64-64bit.tar.gz
cd vpnserver
sudo make

# Set permissions on VPN server files
sudo chmod 600 *
sudo chmod 700 vpnserver
sudo chmod 700 vpncmd

# Start VPN server
sudo ./vpnserver start

# Configure SSTP VPN
sudo ./vpncmd localhost /SERVER /CMD:EnableSSTP
sudo ./vpncmd localhost /SERVER /PASSWORD:serverpassword /CMD:SstpEnable yes
sudo ./vpncmd localhost /SERVER /PASSWORD:serverpassword /CMD:SstpSetLog /INFORMATION:YES

echo "SSTP VPN server installation and configuration complete."
