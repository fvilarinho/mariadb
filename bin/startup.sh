#!/bin/bash

source $BIN_DIR/functions.sh

echo "Gathering the service settings..."

SETTINGS=$(getCredentials)
NAME=`echo $SETTINGS | jq -r .name`
USER=`echo $SETTINGS | jq -r .user`
PASSWORD=`echo $SETTINGS | jq -r .password`
PORT=`echo $SETTINGS | jq -r .port`

export NAME
export USER
export PASSWORD
export PORT

echo "Service settings were gathered!"

$BIN_DIR/install.sh

echo "Starting the service..."

mysqld --user=root --console &

while [ true ];
do
	RESULT=`netstat -an|grep $PORT|grep LISTEN`
	
	if [ -z "$RESULT" ]; then
		sleep 1
	else
		break
	fi
done

echo "Service started!"

$BIN_DIR/permissions.sh

flyway -user="${USER}" -password="${PASSWORD}" migrate

while [ true ];
do
	PID=`pidof mysqld`
	
	if [ ! -z "$PID" ]; then
		sleep 1
	else
		break
	fi
done