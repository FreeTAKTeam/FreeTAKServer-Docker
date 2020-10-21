# Multiple Servers on Single Host

It is possible to run FreeTakServer multiple times on a single host by changing the port numbers.

If you follow an installation guide for your target platform and have a container running named `fts` using the default ports, this will explain how to run a second server on non default ports.

## Running an aditional container

```bash
docker volume create fts_data2

docker run -d -p 8081:8081/tcp -p 8088:8088/tcp -e FTS_CONNECTION_MESSAGE="Server Connection Message" -e FTS_SAVE_COT_TO_DB="True" \ 
-e FTS_ARGS=" -DataPackageIP=0.0.0.0 -CoTIP=0.0.0.0 -CoTPort=8081 -DataPackagePort 8088" \
-v fts_data2:/host/system/folder --name fts2 --restart unless-stopped freetakteam/freetakserver:1.1.2
```

We can use this command as a template to run as many FTS server instances as we would like on a single host by changing the name of the container and the ports FTS is running on.
So long as we avoid collisions on ports and names, if we have the resources we can run multiple servers with ease.
