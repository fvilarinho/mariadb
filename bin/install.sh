#!/bin/bash

cp $ETC_DIR/my.cnf /tmp/my.cnf
sed -i -e 's|${DATABASE_NAME}|'"$DATABASE_NAME"'|g' /tmp/my.cnf
sed -i -e 's|${PORT}|'"$PORT"'|g' /tmp/my.cnf
sed -i -e 's|${DATA_DIR}|'"$DATA_DIR"'|g' /tmp/my.cnf
sed -i -e 's|${LOG_DIR}|'"$LOG_DIR"'|g' /tmp/my.cnf
cp /tmp/my.cnf /etc/my.cnf

cp $ETC_DIR/flyway.conf /tmp/flyway.conf
sed -i -e 's|${DATABASE_NAME}|'"$DATABASE_NAME"'|g' /tmp/flyway.conf
sed -i -e 's|${USER}|'"$USER"'|g' /tmp/flyway.conf
sed -i -e 's|${PORT}|'"$PORT"'|g' /tmp/flyway.conf
cp /tmp/flyway.conf /opt/flyway/conf

if [ ! -d $DATA_DIR/mysql ]; then
	mysql_install_db --user=root
fi