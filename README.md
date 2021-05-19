
# FreeTAKServer-Docker
The official Docker images for FreeTAKServer.

|Image names|Description
| ------------- | ------------- | 
|`freetakteam/freetakserver:FTS-Bundle-dev` |Contains a bundle of FTS+UI+Map into a single docker container for easy use for less technical people. (Map not implemented yet)|
|`freetakteam/freetakserver:FTS-dev` |Only FTS|
|`freetakteam/freetakserver:UI-dev` |Only UI|
|`freetakteam/freetakserver:Map-dev` |Only Freetakhub map (Not currently done)|



## Usage
When using this docker container it is suggested that you use the `--restart unless-stopped` flag as shown in the examples.  This will enure that the service automatically starts with the host and will restart if it encounters an error and crashes.  The port mappings in the examples are required to make the service accessable to hosts.  All environment variables are optional.  All data is stored in a single directory for ease of persistent data between container versions.

```bash
docker run -d -v fts_data:/data -p 5000:5000 -p 8080:8080 -p 8087:8087 -p 8089:8089 -p 8443:8443 -p 19023:19023 --env IP=192.168.0.123 --env MSG="This is my first FTS!" --name MyFirstTakServer freetakteam/freetakserver:1.7.5
```

### Ports
The docker image runs the ports on the same defaults as FreeTAKServer.  You can use the `-e` flag to map these ports to different ports or to run multiple FreeTAKServer's concurrently on the same host.

### Exposed ports 
| Component        | Default port           |
| ------------- |-------------| 
| FTS | 8080 | 
| FTS | 8087 | 
| FTS | 8089 | 
| FTS | 8443 | 
| FTS | 19023 | 
| UI | 5000 | 
| MAP | 8000 | 

### Environment Variabls
#### FTS


| Variable        | Default           | Type  |
| ------------- |:-------------:| ----- |
| DataPackageServiceDefaultIP       | 0.0.0.0 | string |
| UserConnectionIP      | 0.0.0.0      |   string |
| APIIP       | 0.0.0.0      |   string |
| AllowedCLIIPs       | 127.0.0.1      |   list |
| CLIIP      | 127.0.0.1      |   string |
| SaveCoTToDB      | True      |   Boolean |
| MainLoopDelay|1|Delay in milliseconds|
| MSG      |       |   String |

#### UI

| Variable        | Default           | Type  |
| ------------- |:-------------:| ----- |
| IP | 127.0.0.1 | string |
| APPIP | 127.0.0.1 | string |



### Storage
All data in this container is stored in `/data`.  This directory will need to be stored to a volume if you wish to persist data between updates.

# Dockerhub
https://hub.docker.com/r/freetakteam/freetakserver
