#!/bin/bash

if [ ! -z "$DOCKER_REGISTRY_USER" ]; then 
	echo $DOCKER_REGISTRY_PASSWORD | docker login -u $DOCKER_REGISTRY_USER $DOCKER_REGISTRY_URL --password-stdin
fi  

docker-compose build