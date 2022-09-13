#!/bin/bash

echo "###########################"
echo "Preparing"
echo "###########################"

#Touch
#Create log folders
echo "Create logs folder"
mkdir -p /data/logs/supervisor
mkdir -p /data/database/
mkdir -p /data/certs/ClientPackages/
mkdir -p /data/ExCheck/checklist/
echo "Set permissions on data folder"
chmod -R 777 /data

#Setting variables:

#UI Variables

#IP
if [ -z "${IP}" ]; then
  ip=$(ip addr | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
  echo "Using primary interface IP: $ip"
else
  echo "Setting IP: ${IP}"
  ip=${IP}
fi
sed -i "s+IP = .*+IP = '"${ip}"'+g" /usr/local/lib/python3.8/dist-packages/FreeTAKServer-UI/config.py

#APPIP
if [ -z "${APPIP}" ]; then
  echo "Using default IP 127.0.0.1"
else
  echo "Setting APPIP: ${APPIP}"
  sed -i "s+APPIP = .*+APPIP = '"${APPIP}"'+g" /usr/local/lib/python3.8/dist-packages/FreeTAKServer-UI/config.py
fi

echo "###########################"
echo "Preparations completed"
echo "###########################"


supervisord -c /etc/supervisor/conf.d/supervisord.conf
