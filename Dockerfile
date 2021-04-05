FROM debian:10-slim

MAINTAINER FreeTAKTeam

ARG FTS_VERSION=1.7.5.1

RUN apt-get update && \
    apt-get install -y --no-install-recommends curl python3 python3-pip python3-dev python3-setuptools build-essential netbase libxml2-dev libxslt-dev libffi-dev python-flask-httpauth python3-lxml && \
    pip3 install wheel && \
    pip3 install FreeTAKServer==${FTS_VERSION} && \
    pip3 check FreeTakServer && \
    apt-get remove -y python3-pip curl python3-setuptools build-essential python3-dev && \
    apt-get autoremove -y && \
    apt-get autoclean -y && \
    rm -rf /var/lib/apt/lists/*
RUN addgroup --gid 1000 fts && \
    adduser  --uid 1000 --ingroup fts --home /home/fts fts && \
    mkdir -m 775 /data && \
    chown fts:fts /data /home/fts

RUN sed -i s=FreeTAKServerDataPackageDataBase.db=/data/DataPackageDataBase.db=g /usr/local/lib/python3.7/dist-packages/FreeTAKServer/controllers/configuration/DataPackageServerConstants.py && \
    sed -i s=FreeTAKServerDataPackageFolder=/data/DataPackageFolder=g /usr/local/lib/python3.7/dist-packages/FreeTAKServer/controllers/configuration/DataPackageServerConstants.py && \
    sed -i s='logs'='/data/logs'=g /usr/local/lib/python3.7/dist-packages/FreeTAKServer/controllers/configuration/LoggingConstants.py && \
    sed -i 's+DBFilePath = .*+DBFilePath = "/data/FTSDataBase.db"+g' /usr/local/lib/python3.7/dist-packages/FreeTAKServer/controllers/configuration/MainConfig.py && \
    chmod 777 /usr/local/lib/python3.7/dist-packages/FreeTAKServer/controllers/configuration/MainConfig.py && \
    chmod 777 /usr/local/lib/python3.7/dist-packages/FreeTAKServer/controllers/configuration



COPY start-fts.sh /start-fts.sh
RUN chmod +x /start-fts.sh

EXPOSE 8080
EXPOSE 8087

VOLUME ["/data"]
WORKDIR /data
USER fts

ENTRYPOINT ["/bin/bash", "/start-fts.sh"]
