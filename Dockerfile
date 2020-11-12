FROM ghcr.io/concepting-com-br/base-java-image:1.0.0

LABEL maintainer="fvilarinho@concepting.com.br"

ENV APP_NAME=mariadb

ENV SETTINGS_HOSTNAME=host.docker.internal
ENV SETTINGS_PORT=2379
ENV SETTINGS_URL=http://${SETTINGS_HOSTNAME}:${SETTINGS_PORT}

ENV SQL_DIR=${HOME_DIR}/sql

USER root

RUN apk update && \
    apk --no-cache \ 
        add mariadb \
            mariadb-client && \
    apk --no-cache \ 
        --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing \ 
        add etcd-ctl            
            
RUN wget -qO- https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/7.2.0/flyway-commandline-7.2.0-linux-x64.tar.gz | tar xvz && \
	mv ./flyway-7.2.0 /opt && \
	ln -s /opt/flyway-7.2.0 /opt/flyway && \
	rm -rf /opt/flyway/sql && \
	rm -rf /opt/flyway/jre && \
	rm -f /opt/flyway/conf/flyway.conf && \
    ln -s /opt/flyway/flyway /usr/local/bin
    
RUN mkdir -p /run/mysqld \
             ${SQL_DIR} && \
    ln -s ${SQL_DIR} /opt/flyway/sql && \        
    rm -f /etc/my.cnf

COPY src/main/resources/bin/* ${BIN_DIR}/
COPY src/main/resources/etc/my.cnf ${ETC_DIR}/
COPY src/main/resources/etc/flyway.conf ${ETC_DIR}/
COPY src/main/resources/sql/* ${SQL_DIR}/

RUN chmod +x ${BIN_DIR}/*.sh && \
    ln -s ${BIN_DIR}/startup.sh /entrypoint.sh
    
EXPOSE 3306
    
ENTRYPOINT ["/entrypoint.sh"]