#!/bin/bash

if [ ! -z "$REPOSITORY_URL" ]; then 
	echo $REPOSITORY_PASSWORD | docker login -u $REPOSITORY_USER $REPOSITORY_URL --password-stdin
fi 

export BUILD_VERSION=1.0.0

docker-compose build

export BUILD_VERSION=latest

docker-compose build