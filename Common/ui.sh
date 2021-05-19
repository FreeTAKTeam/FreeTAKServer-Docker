#IP
if [ -z "${IP}" ]; then
  echo "Using default IP 127.0.0.1"
else
   echo "Setting IP: ${IP}"
    sed -i "s+IP = .*+IP = '"${IP}"'+g" /usr/local/lib/python3.8/dist-packages/FreeTAKServer-UI/config.py
  fi

#APPIP
if [ -z "${APPIP}" ]; then
  echo "Using default IP 127.0.0.1"
else
   echo "Setting APPIP: ${APPIP}"
    sed -i "s+APPIP = .*+APPIP = '"${APPIP}"'+g" /usr/local/lib/python3.8/dist-packages/FreeTAKServer-UI/config.py
  fi
