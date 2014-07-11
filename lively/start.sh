#!/bin/bash

cd /home/lively/lively-web.org/lively

port=9001
container_name=lively-web-server
lively_host_dir=/home/lively/lively-web.org/data/LivelyKernel

docker_procs=$(docker ps | grep ":$port" | awk '{ print $1 }')
[ -n "$docker_procs" ] && xargs docker stop

[ -z "$(docker ps -a | grep $container_name)" ] && docker build --rm -t $container_name .

docker run \
    --rm \
    -v $lively_host_dir:/home/lively/LivelyKernel \
    -p 8080:9001 \
    -p 9002:9002 \
    -p 9003:9003 \
    -p 9004:9004 \
    -i -t $container_name
