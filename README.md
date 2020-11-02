
# FreeTAKServer-Docker
The official Docker image for FreeTAKServer.

Image Name:
`freetakteam/freetakserver`

We do not have a latest tag currently so you will need to use `freetakteam/freetakteam/freetakserver:1.1.2` please view the full documentation for installation details

## Usage
When using this docker container it is suggested that you use the `--restart unless-stopped` flag as shown in the examples.  This will enure that the service automatically starts with the host and will restart if it encounters an error and crashes.  The port mappings in the examples are required to make the service accessable to hosts.  All environment variables are optional.  All data is stored in a single directory for ease of persistent data between container versions.

```bash
sudo docker run -d -p 8080:8080/tcp -p 8087:8087/tcp -e FTS_CONNECTION_MESSAGE="Server Connection Message" -v fts_data:/data --name fts --restart unless-stopped freetakteam/freetakserver:1.1.2
```

### Ports
The docker image runs the ports on the same defaults as FreeTAKServer.  You can use the `-e` flag to map these ports to different ports or to run multiple FreeTAKServer's concurrently on the same host.

### Environment Variabls
```
FTS_CONNECTION_MESSAGE: Accepts a string to send to users when they connect.  Set to "None" to disable.
FTS_SAVE_COT_TO_DB: Accepts "True" or "False" setting to save CoTs to the DB.
FTS_ARGS: Arguments to pass on the command line, "-AutoStart True" is passed automatically.  
```

### Storage
All data in this container is stored in `/data`.  This directory will need to be stored to a volume if you wish to persist data between updates.

# Full Documentation
For full documetnation on how to use the container visit the docs site:
https://freetakteam.github.io/FreeTAKServer-User-Docs/
