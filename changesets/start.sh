#!/bin/bash

cd /home/lively/lively-web.org/changesets

port=9205
container_name=changesets-server
lively_host_dir=/home/lively/lively-web.org/changesets/repo
log_dir=/home/lively/lively-web.org/changesets/logs
expt_dir=/home/lively/expt

docker_procs=$(docker ps | grep "$port->9001/tcp" | awk '{ print $1 }')
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
    -v /home/lively/lively-web.org/changesets/node-lively-davfs:/home/lively/LivelyKernel/node_modules/life_star/node_modules/lively-davfs \
    -v /home/lively/lively-web.org/changesets/lively-git-helper:/home/lively/LivelyKernel/node_modules/life_star/node_modules/lively-davfs/node_modules/lively-git-helper \
    -v /home/lively/lively-web.org/changesets/lively-git-helper:/home/lively/LivelyKernel/node_modules/lively-git-helper \
    -v $log_dir:/home/lively/logs \
    -v $expt_dir:/home/lively/expt \
    -p 9205:9001 \
    -p 9206:9002 \
    -p 9207:9003 \
    -p 9208:9004 \
    -t \
    $container_name \
    node bin/lk-server -p 9001 --host 0.0.0.0 --behind-proxy

echo "[$(date -R)] Docker exited with $?"
