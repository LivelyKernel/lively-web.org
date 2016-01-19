FROM          node:4-slim
MAINTAINER    Robert Krahn <robert.krahn@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update; \
    apt-get upgrade -y; \
    apt-get -y install curl git bzip2 unzip zip \
                       lsof sysstat dnsutils

# lively user, password: livelyrocks
# openssl passwd -1 livelyrocks
RUN /usr/sbin/useradd \
    --create-home --home-dir /home/lively \
     --shell /bin/bash \
     --groups sudo \
     --password "niHEcdDiD3J1o" \
     lively

# git
ADD gitconfig /home/lively/.gitconfig

# nodejs tooling
RUN npm install -g \
  nodemon forever \
  phantomjs \
  http-server

# For the Lively spell checker:
RUN apt-get install -y aspell

# FIXME 2014-08-12: adding R server for Aran,
# this should really go into its own VM
RUN apt-get install -y --no-install-recommends r-base r-base-dev

# For Lars and Astrid's experiments
RUN apt-get install -y gringo

# For apps.Graphviz
RUN apt-get install -y graphviz

# lively
ENV WORKSPACE_LK=/home/lively/LivelyKernel \
    HOME=/home/lively \
    livelyport=9001

USER lively

WORKDIR /home/lively/LivelyKernel

EXPOSE 9001-9004

# for LivelyR
EXPOSE 8120-8149

CMD rm "*.pid" >/dev/null 2>&1; \
    [ ! -d node_modules/ ] && npm install; \
    forever bin/lk-server.js \
    --port 9001 --host 0.0.0.0 --behind-proxy
