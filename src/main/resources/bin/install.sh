#!/bin/bash

if [ -d /var/lib/mysql/mysql ]; then
	echo "Service already initialized!" 
else
	echo "Service is initializing..." 

	mysql_install_db
	
	echo "Service was initialized!"
fi