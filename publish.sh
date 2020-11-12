#!/bin/bash

docker push $REPOSITORY_URL/$REPOSITORY_NAME/mariadb:latest
docker push $REPOSITORY_URL/$REPOSITORY_NAME/mariadb:1.0.0