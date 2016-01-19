#!/bin/bash

cd /home/lively/lively-web.org/cloxp

port=${1-10080}
logs=$PWD/logs
ts=`date "+%Y-%m-%d_%M-%H-%S"`
logfile="~/logs/$ts-$port-lively.log";
container_name=cloxp-base
clojure_project_dir=$PWD/clojure
cloxp_dir=$PWD/cloxp
m2=$PWD/m2
# lively_project_dir=$cloxp_dir/LivelyKernel

# [ -z "$(docker ps -a | grep $container_name)" ] && \
#     docker build --rm -t cloxp-base .
    # -v $lively_project_dir:/home/lively/LivelyKernel \

echo -e "Starting cloxp container on port $port"
echo -e "Logs are at: $logfile"

docker run \
    -p $port:10080 \
    -v $clojure_project_dir:/home/lively/clojure \
    -v $cloxp_dir:/home/lively/cloxp/install \
    -v $cloxp_dir/LivelyKernel:/home/lively/cloxp/LivelyKernel \
    -v $logs:/home/lively/logs \
    -v $m2:/home/lively/.m2 \
    -t \
    --detach=true \
    $container_name \
      /bin/bash --login -c "touch $logfile; forever bin/lk-server.js --port 10080 --host 0.0.0.0 --behind-proxy --db-config '{\"enableRewriting\":false}' | tee $logfile"

    # --name="cloxp-$port" \
    # $container_name /bin/bash --login

# docker run -it /bin/bash cloxp-base--login

# echo "[$(date -R)] Docker exited with $?"
