#!/bin/bash

echo "Gathering the service settings..."

SETTINGS=
CONT=0

while [ true ];
do
	SETTINGS=`etcdctl --endpoints=$SETTINGS_URL get $APP_NAME`
	
	if [ -z "$SETTINGS" ]; then
		sleep 1	
		
		if [ $CONT == 0 ]; then
			echo "Waiting for the settings be defined..."
			
			CONT=1
		fi
	else
		break
	fi
done

echo "Starting the service..."

$BIN_DIR/install.sh

mysqld --user=root --console &

while [ true ];
do
	PID=`mysql `
	
	if [ ! -z "$PID" ]; then
		sleep 1
	else
		echo "Stopping the service..."
		
		break
	fi
done



echo "Service started!"

while [ true ];
do
	PID=`pidof mysqld`
	
	if [ ! -z "$PID" ]; then
		sleep 1
	else
		echo "Stopping the service..."
		
		break
	fi
done

echo "Service stopped!"