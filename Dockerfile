FROM ubuntu:20.04

MAINTAINER FreeTAKTeam

ARG FTS_VERSION=1.7.5


RUN apt update && \
    apt -y upgrade && \
    apt install -y curl && \
    apt install -y python3-pip && \
    apt install -y python3 && \
    python3 --version && \
    pip3 install supervisor &&\
    pip3 install requests &&\
    pip3 install flask_login &&\
    pip3 install FreeTAKServer[ui]==${FTS_VERSION} && \
    #1.7.1 added dependencies
    pip3 install defusedxml

#non root user
RUN addgroup --gid 1000 fts && \
    adduser  --uid 1000 --ingroup fts --home /home/fts fts && \
    mkdir -m 775 /data && \
    chown fts:fts /data /home/fts
#RUN touch /var/log/FTS_debug.log && \
#    touch /var/log/FTS_error.log && \
#    touch /var/log/FTS_info.log && \
#    chown fts:fts /var/log/FTS_*.log && \
#    chown fts:fts /var/log && \
#    chmod 775 /var/log

#Container friendly supervisor
RUN mkdir -p /var/log/supervisor/ && \
    chown -R fts:fts /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY fatalexit /usr/local/bin/fatalexit && \
    chmod +x /usr/local/bin/fatalexit

#Logrotation
COPY ftsrotate /etc/logrotate.d/ftsrotate

#Asshattery
COPY asn.png /asn.png
#Hacks for making FTS/FTS UI play nice in a container
COPY start-fts.sh /start-fts.sh
RUN chmod +x /start-fts.sh

#FTS ports
EXPOSE 8080
EXPOSE 8087
EXPOSE 8089
EXPOSE 8433
EXPOSE 19023
#FTS UI port
EXPOSE 5000

# Move to volume for persistance 
RUN sed -i 's+DBFilePath = .*+DBFilePath = "/data/FTSDataBase.db"+g' /usr/local/lib/python3.8/dist-packages/FreeTAKServer/controllers/configuration/MainConfig.py &&\
    sed -i 's/root/data/' /usr/local/lib/python3.8/dist-packages/FreeTAKServer-UI/config.py
    

VOLUME ["/data"]


#Use non root user
#USER fts

ENTRYPOINT ["/bin/bash", "/start-fts.sh"]

#CMD ["supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
