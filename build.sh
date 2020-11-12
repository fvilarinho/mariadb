#!/bin/bash

echo $REPOSITORY_PASSWORD | docker login -u $REPOSITORY_USER $REPOSITORY_URL --password-stdin 

docker build -t $REPOSITORY_URL/$REPOSITORY_NAME/mariadb:latest .
docker build -t $REPOSITORY_URL/$REPOSITORY_NAME/mariadb:1.0.0 .