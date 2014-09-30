#!/bin/bash

cd /home/lively/lively-web.org/clojure

port=9081
container_name=lively-clojure
clojure_project_dir=$PWD/lively-clojure
lively_project_dir=$PWD/LivelyKernel

if [[ ! -d $lively_project_dir ]]; then
  git clone https://github.com/LivelyKernel/LivelyKernel $lively_project_dir;
  cp clojure-workspace.html $lively_project_dir/
fi

docker_procs=$(docker ps | grep ":$port" | awk '{ print $1 }')
[ -n "$docker_procs" ] && xargs docker stop

[ -z "$(docker ps -a | grep $container_name)" ] && \
    docker build --rm -t $container_name .

docker run \
    --rm \
    -v $clojure_project_dir:/home/lively/clojure-om \
    -v $lively_project_dir:/home/lively/LivelyKernel \
    -p 7888:7888 \
    -p 7889:7889 \
    -p 9050:9050 \
    -p 9080:9080 \
    -p 9081:9081 \
    -p 9082:9082 \
    -p 9083:9083 \
    -p 9084:9084 \
    -t \
    $container_name
    # $container_name /bin/bash --login

echo "[$(date -R)] Docker exited with $?"
