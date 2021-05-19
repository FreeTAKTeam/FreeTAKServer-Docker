FROM ubuntu:20.04

ARG FTS-VERSION=1.8.1

# UTC for buildtimes
RUN ln -fs /usr/share/zoneinfo/UTC /etc/localtime

#APT
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y libssl-dev libffi-dev curl python3 python3-pip libxml2-dev libxslt-dev python3-lxml python3-dev python3-setuptools build-essential

#PIP3
RUN pip3 install supervisor &&\
    pip3 install requests &&\
    pip3 install flask_login &&\
    pip3 install FreeTAKServer[ui]==${FTS-VERSION} && \
    pip3 install defusedxml &&\
    pip3 install pyopenssl

# Create FTS user
RUN addgroup --gid 1000 fts && \
    adduser --disabled-password --uid 1000 --ingroup fts --home /home/fts fts


# Start script
# This handles env variables and starts the service
COPY /Common/fts.sh fts.sh
COPY /Common/ui.sh ui.sh
COPY /Common/map.sh map.sh
COPY /FTS-Bundle/start-fts.sh /start-fts.sh
RUN chmod +x /start-fts.sh
RUN chmod +x /fts.sh
RUN chmod +x /ui.sh
RUN chmod +x /map.sh

# FTS UI port
EXPOSE 5000

# FTS Config changes
# The last two seds here are dirty and should be changed, this will break if main config changes!
RUN sed -i s=FreeTAKServerDataPackageDataBase.db=/data/database/DataPackageDataBase.db=g /usr/local/lib/python3.8/dist-packages/FreeTAKServer/controllers/configuration/DataPackageServerConstants.py && \
    sed -i s=FreeTAKServerDataPackageFolder=/data/FreeTAKServerDataPackageFolder=g /usr/local/lib/python3.8/dist-packages/FreeTAKServer/controllers/configuration/DataPackageServerConstants.py && \
    sed -i "s+self.PARENTPATH = .*+self.PARENTPATH = '\/data'+g" /usr/local/lib/python3.8/dist-packages/FreeTAKServer/controllers/configuration/LoggingConstants.py && \
    sed -i "s+self.LOGDIRECTORY = .*+self.LOGDIRECTORY = '/data/logs'+g" /usr/local/lib/python3.8/dist-packages/FreeTAKServer/controllers/configuration/LoggingConstants.py &&\
    sed -i 's+DBFilePath = .*+DBFilePath = "/data/database/FTSDataBase.db"+g' /usr/local/lib/python3.8/dist-packages/FreeTAKServer/controllers/configuration/MainConfig.py && \
    sed -e '52d;53d' -i /usr/local/lib/python3.8/dist-packages/FreeTAKServer/controllers/configuration/MainConfig.py &&\
    #Fix main path
    sed -e '52i\ \ \ \ \ \ \ \ \ \ \ \ MainPath = "/data"' -i /usr/local/lib/python3.8/dist-packages/FreeTAKServer/controllers/configuration/MainConfig.py &&\
    #Set excessive config properties
    chmod 777 /usr/local/lib/python3.8/dist-packages/FreeTAKServer/controllers/configuration/MainConfig.py && \
    chmod 777 /usr/local/lib/python3.8/dist-packages/FreeTAKServer/controllers/configuration

# UI Config changes
RUN sed -i 's/root/data/g' /usr/local/lib/python3.8/dist-packages/FreeTAKServer-UI/config.py &&\
    sed -i 's+certpath = .*+certpath = "/data/certs/"+g' /usr/local/lib/python3.8/dist-packages/FreeTAKServer-UI/config.py  &&\
    #Adjust database path
    sed -i 's/data\/FTSDataBase.db/data\/database\/FTSDataBase.db/g' /usr/local/lib/python3.8/dist-packages/FreeTAKServer-UI/config.py &&\
    chmod 777 /usr/local/lib/python3.8/dist-packages/FreeTAKServer-UI/config.py &&\
    chmod 777 /usr/local/lib/python3.8/dist-packages/FreeTAKServer-UI/

VOLUME ["/data"]


ENTRYPOINT ["/bin/bash", "/start-fts.sh"]
