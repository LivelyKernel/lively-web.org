FROM          dockerfile/nodejs
MAINTAINER    Robert Krahn <robert.krahn@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update; \
    apt-get upgrade -y; \
    apt-get -y install curl git bzip2 unzip zip \
                       lsof sysstat dnsutils

# lively user
RUN /usr/sbin/useradd \
    --create-home --home-dir /home/lively \
     --shell /bin/bash \
     --groups sudo \
     --password niHEcdDiD3J1o \
     lively

# git
ADD gitconfig /home/lively/.gitconfig

# nodejs tooling
RUN npm install -g \
  node-inspector \
  nodemon forever \
  phantomjs \
  http-server \
  grunt-cli

# FIXME 2014-08-12: adding R server for Aran,
# this should really go into its own VM
RUN apt-get install -y --no-install-recommends r-base r-base-dev

# For the Lively spell checker:
RUN apt-get install -y aspell

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

EXPOSE 9001 9002 9003 9004

# for LivelyR
EXPOSE 8120 \
       8121 \
       8122 \
       8123 \
       8124 \
       8125 \
       8126 \
       8127 \
       8128 \
       8129 \
       8130 \
       8131 \
       8132 \
       8133 \
       8134 \
       8135 \
       8136 \
       8137 \
       8138 \
       8139 \
       8140 \
       8141 \
       8142 \
       8143 \
       8144 \
       8145 \
       8146 \
       8147 \
       8148 \
       8149

CMD rm *.pid; \
    node bin/lk-server -p 9001 --behind-proxy
