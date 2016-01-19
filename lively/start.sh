#!/bin/bash

cd /home/lively/lively-web.org/lively

port=9001
container_name=lively-web-server
lively_host_dir=/home/lively/lively-web.org/data/LivelyKernel
log_dir=/home/lively/lively-web.org/logs
expt_dir=/home/lively/expt

docker_procs=$(docker ps | grep "$port/tcp" | awk '{ print $1 }')
if [ -n "$docker_procs" ]; then
    echo "docker for container $container_name already running ($docker_procs)... stopping it..."
    sleep 1
    docker stop $docker_procs
    sleep 1
fi

# [ -z "$(docker ps -a | grep $container_name)" ] && docker build --rm -t $container_name .
# docker build --rm -t lively-web-server .

docker run \
    --rm \
    -v $lively_host_dir:/home/lively/LivelyKernel \
    -v $log_dir:/home/lively/logs \
    -v $expt_dir:/home/lively/expt \
    -p 8080:$port \
    -p 9002-9004:9002-9004 \
    -p 8121-8149:8121-8149 \
    -t \
    $container_name \
    node bin/lk-server -p $port --host 0.0.0.0 --behind-proxy

echo "[$(date -R)] Docker exited with $?"
