#!/bin/bash

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# setup steno stuff
yum -y install epel-release
yum -y install jq tcpdump
read -p "Hostname or IP of remote Stenographer server? " HNAME
mkdir -p /etc/stenographer/certs
cat ./config | sudo jq --arg v "$HNAME" '."Host"=$v' > /etc/stenographer/config
cp ./stenoread /usr/bin/
cp ./stenocurl /usr/bin/

# move over certs
read -r -p "Grab client_cert.pem & client_key.pem from root@$HNAME? [y/N] " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then
  scp root@$HNAME:"/etc/stenographer/certs/client_cert.pem /etc/stenographer/certs/client_key.pem" /etc/stenographer/certs/
  chmod 644 /etc/stenographer/certs/client_cert.pem
  chmod 644 /etc/stenographer/certs/client_key.pem
else
  echo "Ok, remember to put in the certs manually then!"
fi

# setup webserver
yum -y install httpd
systemctl enable httpd.service
yes | cp -rf ./index.html /var/www/html/
yes | cp -rf ./grab.py /var/www/cgi-bin/
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --reload
mkdir /tmp/stenoremote
chmod 777 /tmp/stenoremote

# disable selinux
read -r -p "This app requires disabling SELINUX and rebooting, continue? [y/N] " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then
  sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/sysconfig/selinux
  reboot
else
  echo "install.sh terminated, stenoremote not installed."
fi
