# Raspberry Pi 4/Raspberry Pi 3
It is recommended to use a Raspberry Pi 4 with 4GB or 8GB of ram.

This guide assums that you have a clean install of Raspberry Pi OS or Raspbian.
You may also use the 64 bit ubuntu 20.04 LTS.

#### Install Docker
```bash
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install curl 
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```
#### Run the Container
```bash
sudo docker volume create fts_data
```

```bash
sudo docker run -d -p 8080:8080/tcp -p 8087:8087/tcp -e FTS_CONNECTION_MESSAGE="Server Connection Message" -v fts_data:/data --name fts --restart unless-stopped freetakteam/freetakserver:1.1.2
```

# Older Pi's
Raspberry Pi's prior to the Pi3 have not been tested, and would not be reccomended for use.
