#!/bin/bash

#verify if we have access to datadir
if ! touch /data/.verify_access; then
  log "ERROR: /data doesn't seem to be writable. Please make sure attached directory is writable by uid=$(id -u)"
  exit 2
fi

#FTS doesn't pre-create logs directory
mkdir -pv /data/logs


#Set server message if passed in
if [ -z "${FTS_CONNECTION_MESSAGE}" ]; then
  echo "Using Default Connection Message"
else
  if [ "${FTS_CONNECTION_MESSAGE}" = "None" ]; then
    sed -i "s+ConnectionMessage = .*+ConnectionMessage = None+g" /usr/local/lib/python3.7/dist-packages/FreeTAKServer/controllers/configuration/MainConfig.py
  else
    echo "Setting Server Message ${FTS_CONNECTION_MESSAGE}"
    sed -i "s+ConnectionMessage = .*+ConnectionMessage = '${FTS_CONNECTION_MESSAGE}'+g" /usr/local/lib/python3.7/dist-packages/FreeTAKServer/controllers/configuration/MainConfig.py
  fi
fi

#Set Save CoT to DB
if [ -z "${FTS_SAVE_COT_TO_DB}" ]; then
  echo "Using Default SaveCoTToDB"
else
  sed -i "s+SaveCoTToDB = bool(.*+SaveCoTToDB = bool(${FTS_SAVE_COT_TO_DB})+g" /usr/local/lib/python3.7/dist-packages/FreeTAKServer/controllers/configuration/MainConfig.py
fi


FTS_ARGS=""

#set external IP if it's provided via ENV variables
if [ -z ${FTS_ARGS} ]; then
  python3 -m FreeTAKServer.controllers.services.FTS -DataPackageIP 0.0.0.0 -AutoStart True
else
  echo "IP Defined: ${FTS_ARGS}"
  python3 -m FreeTAKServer.controllers.services.FTS ${FTS_ARGS} -AutoStart True
fi
