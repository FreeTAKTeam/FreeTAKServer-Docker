FROM ubuntu:20.04

MAINTAINER FreeTAKTeam

ARG FTS_VERSION=1.7.5

# UTC for buildtimes
RUN ln -fs /usr/share/zoneinfo/UTC /etc/localtime

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y curl python3 python3-pip libxml2-dev libxslt-dev python3-lxml python3-dev python3-setuptools build-essential

RUN python3 --version && \
    pip3 install supervisor &&\
    pip3 install requests &&\
    pip3 install flask_login &&\
    pip3 install FreeTAKServer[ui]==${FTS_VERSION} && \
    pip3 install defusedxml

# non root user
RUN addgroup --gid 1000 fts && \
    adduser  --uid 1000 --ingroup fts --home /home/fts fts && \
    mkdir -m 775 /data && \
    mkdir -p /data/logs && \
    chmod 775 /data/logs && \
    chown fts:fts -R /data /home/fts

# Container friendly supervisor
RUN mkdir -p /data/logs/supervisor/ && \
    chown -R fts:fts /data/logs/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY fatalexit /usr/local/bin/fatalexit
RUN  chmod +x /usr/local/bin/fatalexit

# Logrotation
COPY ftsrotate /etc/logrotate.d/ftsrotate

# Start script
# This handles env variables and starts the service
COPY start-fts.sh /start-fts.sh
RUN chmod +x /start-fts.sh

# FTS ports
EXPOSE 8080
EXPOSE 8086
EXPOSE 8087
EXPOSE 8089
EXPOSE 8443
EXPOSE 19023
# FTS UI port
EXPOSE 5000

# FTS Config changes
# The last two seds here are dirty and should be changed, this will break if main config changes!
RUN sed -i s=FreeTAKServerDataPackageDataBase.db=/data/DataPackageDataBase.db=g /usr/local/lib/python3.8/dist-packages/FreeTAKServer/controllers/configuration/DataPackageServerConstants.py && \
    sed -i s=FreeTAKServerDataPackageFolder=/data/DataPackageFolder=g /usr/local/lib/python3.8/dist-packages/FreeTAKServer/controllers/configuration/DataPackageServerConstants.py && \
    sed -i "s+self.PARENTPATH = .*+self.PARENTPATH = '\/data'+g" /usr/local/lib/python3.8/dist-packages/FreeTAKServer/controllers/configuration/LoggingConstants.py && \
    sed -i "s+self.LOGDIRECTORY = .*+self.LOGDIRECTORY = '/data/logs'+g" /usr/local/lib/python3.8/dist-packages/FreeTAKServer/controllers/configuration/LoggingConstants.py &&\
    sed -i 's+DBFilePath = .*+DBFilePath = "/data/FTSDataBase.db"+g' /usr/local/lib/python3.8/dist-packages/FreeTAKServer/controllers/configuration/MainConfig.py && \
    sed -e '52d;53d' -i /usr/local/lib/python3.8/dist-packages/FreeTAKServer/controllers/configuration/MainConfig.py &&\
    sed -e '52i\ \ \ \ MainPath = "/data"' -i /usr/local/lib/python3.8/dist-packages/FreeTAKServer/controllers/configuration/MainConfig.py &&\
    chmod 777 /usr/local/lib/python3.8/dist-packages/FreeTAKServer/controllers/configuration/MainConfig.py && \
    chmod 777 /usr/local/lib/python3.8/dist-packages/FreeTAKServer/controllers/configuration

# Hack to not have to wait for 1.8 to get performance
RUN sed -e '604i\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ time.sleep(0.01)' -i /usr/local/lib/python3.8/dist-packages/FreeTAKServer/controllers/services/FTS.py

# UI Config changes
RUN sed -i 's/root/data/g' /usr/local/lib/python3.8/dist-packages/FreeTAKServer-UI/config.py &&\
    sed -i 's+certpath = .*+certpath = "/data/certs/"+g' /usr/local/lib/python3.8/dist-packages/FreeTAKServer-UI/config.py  &&\
    chmod 777 /usr/local/lib/python3.8/dist-packages/FreeTAKServer-UI/config.py &&\
    chmod 777 /usr/local/lib/python3.8/dist-packages/FreeTAKServer-UI/

VOLUME ["/data"]


# Use non root user
#USER fts

ENTRYPOINT ["/bin/bash", "/start-fts.sh"]
