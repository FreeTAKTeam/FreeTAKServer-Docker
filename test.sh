docker build -t test .
docker stop test
docker rm test
docker run -d -p 5000:5000 -p 8080:8080 -p 8087:8087 -p 8089:8089 -p 8433:8433 -p 19023:19023 --name test test
#docker logs test

watch -n 0.5 docker logs test
