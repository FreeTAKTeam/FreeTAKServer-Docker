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

#If APIIP specified, use that, otherwise use IP
if [ -z "${APIIP}" ]; then
  if [ -z "${IP}" ]; then
    echo "Using default APIIP 127.0.0.1"
  else
     echo "Setting APIIP: ${IP}"
      sed -i "s+IP = .*+IP = '"${IP}"'+g" /usr/local/lib/python3.8/dist-packages/FreeTAKServer-UI/config.py
  fi
else
   echo "Setting APIIP: ${APIIP}"
    sed -i "s+IP = .*+IP = '"${APIIP}"'+g" /usr/local/lib/python3.8/dist-packages/FreeTAKServer-UI/config.py
  fi

#APIPORT
if [ -z "${APIPORT}" ]; then
  echo "Using default APIPORT 19023"
else
   echo "Setting APIPORT: ${APIPORT}"
    sed -i "s+PORT = .*+PORT = '"${APIPORT}"'+g" /usr/local/lib/python3.8/dist-packages/FreeTAKServer-UI/config.py
  fi

#APIPROTOCOL
if [ -z "${APIPROTOCOL}" ]; then
  echo "Using default APIPROTOCOL http"
else
   echo "Setting APIPROTOCOL: ${APIPROTOCOL}"
    sed -i "s+PROTOCOL = .*+PROTOCOL = '"${APIPROTOCOL}"'+g" /usr/local/lib/python3.8/dist-packages/FreeTAKServer-UI/config.py
  fi

#APPIP
if [ -z "${APPIP}" ]; then
  echo "Using default APPIP 127.0.0.1"
else
   echo "Setting APPIP: ${APPIP}"
    sed -i "s+APPIP = .*+APPIP = '"${APPIP}"'+g" /usr/local/lib/python3.8/dist-packages/FreeTAKServer-UI/config.py
  fi

#APPPORT
if [ -z "${APPPORT}" ]; then
  echo "Using default APPPORT 5000"
else
   echo "Setting APPPORT: ${APPPORT}"
    sed -i "s+APPPort = .*+APPPort = "${APPPORT}"+g" /usr/local/lib/python3.8/dist-packages/FreeTAKServer-UI/config.py
  fi

#WEBMAPIP
if [ -z "${WEBMAPIP}" ]; then
  echo "Using default WEBMAPIP 127.0.0.1"
else
   echo "Setting WEBMAPIP: ${WEBMAPIP}"
    sed -i "s+WEBMAPIP = .*+WEBMAPIP = '"${WEBMAPIP}"'+g" /usr/local/lib/python3.8/dist-packages/FreeTAKServer-UI/config.py
  fi

#WEBMAPPROTOCOL
if [ -z "${WEBMAPPROTOCOL}" ]; then
  echo "Using default WEBMAPPROTOCOL http"
else
   echo "Setting WEBMAPPROTOCOL: ${WEBMAPPROTOCOL}"
    sed -i "s+WEBMAPPROTOCOL = .*+WEBMAPPROTOCOL = '"${WEBMAPPROTOCOL}"'+g" /usr/local/lib/python3.8/dist-packages/FreeTAKServer-UI/config.py
  fi

#WEBMAPPORT
if [ -z "${WEBMAPPORT}" ]; then
  echo "Using default WEBMAPPORT 8000"
else
   echo "Setting WEBMAPPORT: ${WEBMAPPORT}"
    sed -i "s+WEBMAPPORT = .*+WEBMAPPORT = "${WEBMAPPORT}"+g" /usr/local/lib/python3.8/dist-packages/FreeTAKServer-UI/config.py
  fi

echo "###########################"
echo "Preparations completed"
echo "###########################"


supervisord -c /etc/supervisor/conf.d/supervisord.conf
