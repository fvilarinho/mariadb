FROM ghcr.io/fvilarinho/base-java-image:1.1.0

LABEL maintainer="fvilarinho@gmail.com"

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

COPY bin/startup.sh ${BIN_DIR}/child-startup.sh
COPY bin/install.sh ${BIN_DIR}/child-install.sh
COPY bin/permissions.sh ${BIN_DIR}/child-permissions.sh
COPY etc/my.cnf ${ETC_DIR}/
COPY etc/flyway.conf ${ETC_DIR}/
COPY sql/* ${SQL_DIR}/
COPY .env ${ETC_DIR}/.release

RUN chmod +x ${BIN_DIR}/child-*.sh && \
    chown -R user:group ${HOME_DIR}/ && \
    chmod -R o-rwx ${HOME_DIR}/

EXPOSE 3306
    
CMD ["${BIN_DIR}/child-startup.sh"]