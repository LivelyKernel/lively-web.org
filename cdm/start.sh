#!/bin/bash

cd /home/lively/lively-web.org/cdm

port=9201
container_name=cdm-server
lively_host_dir=/home/lively/lively-web.org/cdm/repo
log_dir=/home/lively/lively-web.org/cdm/logs
expt_dir=/home/lively/expt

docker_procs=$(docker ps | grep "$port/tcp" | awk '{ print $1 }')
if [ -n "$docker_procs" ]; then
    echo "docker for container $container_name already running ($docker_procs)... stopping it..."
    sleep 1
    docker stop $docker_procs
    sleep 1
fi

# [ -z "$(docker ps -a | grep $container_name)" ] && docker build --rm -t $container_name .

docker run \
    --rm \
    -v $lively_host_dir:/home/lively/LivelyKernel \
    -v $log_dir:/home/lively/logs \
    -v $expt_dir:/home/lively/expt \
    -p 9201:9001 \
    -p 9202:9002 \
    -p 9203:9003 \
    -p 9204:9004 \
    -t \
    $container_name \
    node bin/lk-server -p 9001 --host 0.0.0.0 --behind-proxy

echo "[$(date -R)] Docker exited with $?"
