#!/bin/bash

export BUILD_VERSION=1.0.0

docker-compose push

export BUILD_VERSION=latest

docker-compose push