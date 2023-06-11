this script installs and configures sstp vpn server on linux

```
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
```

Here's how the script works:

1. The script starts by updating the package list using the `apt-get update` command.
2. The script installs the required packages for building SoftEther VPN server from source.
3. The script downloads the SoftEther VPN server package from the official SoftEther website.
4. The script extracts the package and enters the `vpnserver` directory.
5. The script builds SoftEther VPN server using the `make` command.
6. The script sets the appropriate permissions on the VPN server files using the `chmod` command.
7. The script starts the VPN server using the `./vpnserver start` command.
8. The script configures SSTP VPN by enabling it and setting the log level to information.

Note that this script assumes that you are running a Linux distribution based on Debian or Ubuntu. If you are using a different distribution, you may need to modify the script to use a different package manager or download location for SoftEther VPN server. Additionally, you will need to configure firewall rules to allow incoming traffic on the SSTP VPN port (TCP 443) and forward it to your server. Finally, you will need to configure user accounts and security settings on your VPN server, which are beyond the scope of this script.
