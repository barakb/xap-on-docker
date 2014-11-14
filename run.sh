#!/bin/bash

docker run --privileged=true -ti --name=$1 -h $1 barakb/jdk8

