FROM ghcr.io/concepting-com-br/base-image:1.0.0

LABEL maintainer="fvilarinho@concepting.com.br"

ENV APP_NAME=mariadb

ENV SETTINGS_HOSTNAME=host.docker.internal
ENV SETTINGS_PORT=2379
ENV SETTINGS_URL=http://${SETTINGS_HOSTNAME}:${SETTINGS_PORT}

ENV SQL_DIR=${HOME_DIR}/sql

RUN apk update && \
    apk --no-cache \ 
        add mariadb \
            mariadb-client && \
    apk --no-cache \ 
        --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing \ 
        add etcd-ctl            
            
RUN wget -qO- https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/7.2.0/flyway-commandline-7.2.0-linux-x64.tar.gz | tar xvz && \
    ln -s `pwd`/flyway-7.2.0/flyway /usr/local/bin
    
RUN mkdir -p /run/mysqld \
             /var/log/mysql \
             ${SQL_DIR} && \
    ln -s ${DATA_DIR} /var/lib/mysql && \
    rm -f /etc/my.cnf

COPY src/main/resources/bin/* ${BIN_DIR}/
COPY src/main/resources/etc/* ${ETC_DIR}/
COPY src/main/resources/sql/* ${SQL_DIR}/

RUN chmod +x ${BIN_DIR}/*.sh && \
    ln -s ${ETC_DIR}/my.cnf /etc/my.cnf && \
    ln -s ${BIN_DIR}/startup.sh /entrypoint.sh
    
EXPOSE 3306    
    
ENTRYPOINT ["/entrypoint.sh"]