#!/bin/bash

cd /home/lively/lively-web.org/cloxp

port=${1-10080}
logs=$PWD/logs
container_name=cloxp-base
clojure_project_dir=$PWD/clojure
cloxp_dir=$PWD/cloxp
m2=$PWD/m2
# lively_project_dir=$cloxp_dir/LivelyKernel

# [ -z "$(docker ps -a | grep $container_name)" ] && \
#     docker build --rm -t cloxp-base .
    # -v $lively_project_dir:/home/lively/LivelyKernel \

docker run \
    -p $port:10080 \
    -v $clojure_project_dir:/home/lively/clojure \
    -v $cloxp_dir:/home/lively/cloxp/install \
    -v $cloxp_dir/LivelyKernel:/home/lively/cloxp/LivelyKernel \
    -v $logs:/home/lively/logs \
    -v $m2:/home/lively/.m2 \
    -it \
    cloxp-base \
    /bin/bash --login

#     # --name="cloxp-$port" \
#     # $container_name /bin/bash --

# docker run -it cloxp-base /bin/bash --login

# echo "[$(date -R)] Docker exited with $?"
