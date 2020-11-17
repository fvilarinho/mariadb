#!/bin/bash

NAME=`echo $SETTINGS | jq -r .name`
USER=`echo $SETTINGS | jq -r .user`
PASSWORD=`echo $SETTINGS | jq -r .password`

export NAME
export USER
export PASSWORD

$BIN_DIR/$APP_NAME-install.sh

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

$BIN_DIR/$APP_NAME-permissions.sh

flyway -user="${USER}" -password="${PASSWORD}" migrate