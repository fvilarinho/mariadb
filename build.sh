#!/bin/bash

if [ ! -z "$REPOSITORY_URL" ]; then 
	echo $REPOSITORY_PASSWORD | docker login -u $REPOSITORY_USER $REPOSITORY_URL --password-stdin
fi 

docker-compose build