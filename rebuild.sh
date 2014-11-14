#!/bin/bash

./rm.sh
docker rmi -f barakb/jdk8
./build.sh
