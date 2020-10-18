
# FreeTAKServer-Docker
The official Docker image for FreeTAKServer.

## Usage

This docker image supports a few optional configuration variables
```
FTS_CONNECTION_MESSAGE: accepts a string to send to users when they connect 
FTS_SAVE_COT_TO_DB: accepts "True" or "False" setting to save CoTs to the DB
```
### Docker run samples

#### Quick Start
This will run FreeTAKServer without persistent data storage with all default settings.
```
docker run -d -p 8080:8080/tcp -p 8087:8087/tcp --name fts --restart unless-stopped freetakteam/freetakserver:1.1.2
```
#### Persistent Data

All persistent data is stored to /data and may be volume mounted.  The host volume needs to be owned by user and group 1000.
```
docker volume create fts_data

docker run -d -p 8080:8080/tcp -p 8087:8087/tcp -e FTS_CONNECTION_MESSAGE="Server Connection Message" -e FTS_SAVE_COT_TO_DB="True" -v fts_data:/host/system/folder --name fts --restart unless-stopped freetakteam/freetakserver:1.1.2
```
It is also possible to use an absolute path on the host instead of a proper volume.  For more information about volumes https://docs.docker.com/storage/volumes/

### Detailed Installation

#### Debian
This is assuming a fresh installation of Debian 10.
##### Install Docker
```
sudo apt-get install curl
curl https://releases.rancher.com/install-docker/19.03.sh | sh
```
Or follow the docker installation guide.
https://docs.docker.com/engine/install/debian/

##### Run the container
```
docker volume create fts_data

docker run -d -p 8080:8080/tcp -p 8087:8087/tcp -e FTS_CONNECTION_MESSAGE="Server Connection Message" -e FTS_SAVE_COT_TO_DB="True" -v fts_data:/host/system/folder --name fts --restart unless-stopped freetakteam/freetakserver:1.1.2
```

#### Raspberry Pi 4
It is recommended to use a Raspberry Pi 4 with 4GB or 8GB of ram.

##### Install Docker
```
sudo apt-get install curl 
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```
##### Run the container
```
docker volume create fts_data

docker run -d -p 8080:8080/tcp -p 8087:8087/tcp -e FTS_CONNECTION_MESSAGE="Server Connection Message" -e FTS_SAVE_COT_TO_DB="True" -v fts_data:/host/system/folder --name fts --restart unless-stopped freetakteam/freetakserver:1.1.2
```

## Additional Architectures
Currently the container is being cross compiled for `linux/amd64`,  `linux/arm64` and `linux/arm/v7`.  If additional processor architectures are needed please open an issue and request a new one.

## Docker Hub Page
https://hub.docker.com/repository/docker/freetakteam/freetakserver
