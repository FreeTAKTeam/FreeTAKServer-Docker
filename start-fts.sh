echo "###########################"
echo "Preparing"
echo "###########################"

#Setting variables:

#DataPackageServiceDefaultIP
if [ -z "${DataPackageServiceDefaultIP}" ]; then
  echo "Using default DataPackageServiceDefaultIP 0.0.0.0"
else
   echo "Setting default user connection IP: ${DataPackageServiceDefaultIP}"
    sed -i "s+DataPackageServiceDefaultIP = .*+DataPackageServiceDefaultIP = 'str(os.environ.get('FTS_DP_ADDRESS', '"${DataPackageServiceDefaultIP}"'))+g" /usr/local/lib/python3.8/dist-packages/FreeTAKServer/controllers/configuration/MainConfig.py
  fi

#UserConnectionIP
if [ -z "${UserConnectionIP}" ]; then
  echo "Using default UserConnectionIP 0.0.0.0"
else
   echo "Setting user connection IP: ${UserConnectionIP}"
    sed -i "s+UserConnectionIP = .*+UserConnectionIP = 'str(os.environ.get('FTS_USER_ADDRESS', '"${UserConnectionIP}"'))+g" /usr/local/lib/python3.8/dist-packages/FreeTAKServer/controllers/configuration/MainConfig.py
  fi

#APIIP
if [ -z "${APIIP}" ]; then
  echo "Using default APIIP 0.0.0.0"
else
   echo "Setting user connection IP: ${APIIP}"
    sed -i "s+APIIP = .*+APIIP = os.environ.get('FTS_API_ADDRESS', '"${APIIP}"')+g" /usr/local/lib/python3.8/dist-packages/FreeTAKServer/controllers/configuration/MainConfig.py
  fi


#AllowedCLIIPs
if [ -z "${AllowedCLIIPs}" ]; then
  echo "Using default AllowedCLIIPs [127.0.0.1]"
else
   echo "Setting AllowedCLIIPs: ${AllowedCLIIPs}"
    sed -i "s+AllowedCLIIPs = .*+AllowedCLIIPs = ['"${AllowedCLIIPs}"']+g" /usr/local/lib/python3.8/dist-packages/FreeTAKServer/controllers/configuration/MainConfig.py
  fi

#CLIIP
if [ -z "${CLIIP}" ]; then
  echo "Using default CLIIP 127.0.0.1"
else
   echo "Setting CLIIP: ${CLIIP}"
    sed -i "s+CLIIP = .*+CLIIP = '"${CLIIP}"'+g" /usr/local/lib/python3.8/dist-packages/FreeTAKServer/controllers/configuration/MainConfig.py
  fi

#SaveCoTToDB
if [ -z "${SaveCoTToDB}" ]; then
  echo "Using Default SaveCoTToDB (True)"
else
  echo "Setting SaveCoTToDB to ${SaveCoTToDB}"
  sed -i "s+SaveCoTToDB = .*+SaveCoTToDB = bool(os.environ.get('FTS_API_ADDRESS', '"${SaveCoTToDB}"'))+g" /usr/local/lib/python3.8/dist-packages/FreeTAKServer/controllers/configuration/MainConfig.py
fi

if [ -z "${MSG}" ]; then
  echo "Using Default Connection Message"
else
  if [ "${MSG}" = "None" ]; then
    sed -i "s+ConnectionMessage = .*+ConnectionMessage = None+g" /usr/local/lib/python3.8/dist-packages/FreeTAKServer/controllers/configuration/MainConfig.py
  else
    echo "Setting Server Message: ${MSG}"
    sed -i "s+ConnectionMessage = .*+ConnectionMessage = '${MSG}'+g" /usr/local/lib/python3.8/dist-packages/FreeTAKServer/controllers/configuration/MainConfig.py
  fi
fi


#UI Variables

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

echo "###########################"
echo "Preparations completed"
echo "###########################"


supervisord -c /etc/supervisor/conf.d/supervisord.conf
