#!/bin/bash

brew install jq
brew install curl --with-openssl && brew link curl --force
read -p "Hostname or IP of remote Stenographer server? " HNAME
sudo mkdir -p /etc/stenographer/certs
cat ./config | jq --arg v "$HNAME" '."Host"=$v' > ./tmp_config
sudo mv ./tmp_config /etc/stenographer/config
sudo cp ./stenoread /usr/bin
sudo cp ./stenocurl /usr/bin

# need to go in and change curl source after brew, and force linking
# using a which curl
