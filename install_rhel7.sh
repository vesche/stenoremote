#!/bin/bash

sudo yum -y install epel-release
sudo yum -y install jq tcpdump
read -p "Hostname or IP of remote Stenographer server? " HNAME
sudo mkdir -p /etc/stenographer/certs
cat ./config | sudo jq --arg v "$HNAME" '."Host"=$v' > /etc/stenographer/config
sudo cp ./stenoread /usr/bin/
sudo cp ./stenocurl /usr/bin/
