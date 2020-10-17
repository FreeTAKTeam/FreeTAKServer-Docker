# FreeTAKServer-Docker


## Usage

This docker image supports a few optional configuration variables

FTS_CONNECTION_MESSAGE: accepts a string to send to users when they connect 
FTS_SAVE_COT_TO_DB: accepts "True" or "False" setting to save CoTs to the DB

all persistent data is stored to /data and may be volume mounted.  The host volume needs to be owned by user and group 1000.


```
docker run -d -p 8080:8080 -p 8087:8087 -e FTS_CONNECTION_MESSAGE="Server Connection Message" -e FTS_SAVE_COT_TO_DB="True" -v /host/system/folder:/data  --name fts --restart unless-stopped freetakteam/freetakserver:1.1.2
```
