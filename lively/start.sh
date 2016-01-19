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
    -p 8080:9001 \
    -p 9002:9002 \
    -p 9003:9003 \
    -p 9004:9004 \
    -p 8121:8121 \
    -p 8122:8122 \
    -p 8123:8123 \
    -p 8124:8124 \
    -p 8125:8125 \
    -p 8126:8126 \
    -p 8127:8127 \
    -p 8128:8128 \
    -p 8129:8129 \
    -p 8130:8130 \
    -p 8131:8131 \
    -p 8132:8132 \
    -p 8133:8133 \
    -p 8134:8134 \
    -p 8135:8135 \
    -p 8136:8136 \
    -p 8137:8137 \
    -p 8138:8138 \
    -p 8139:8139 \
    -p 8140:8140 \
    -p 8141:8141 \
    -p 8142:8142 \
    -p 8143:8143 \
    -p 8144:8144 \
    -p 8145:8145 \
    -p 8146:8146 \
    -p 8147:8147 \
    -p 8148:8148 \
    -p 8149:8149 \
    -t \
    $container_name \
    node bin/lk-server -p 9001 --host 0.0.0.0 --behind-proxy

echo "[$(date -R)] Docker exited with $?"
