FROM          dockerfile/nodejs
MAINTAINER    Robert Krahn <robert.krahn@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get -y install curl git bzip2 unzip zip
RUN apt-get install lsof

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
RUN npm install -g node-inspector
RUN npm install forever -g

# FIXME 2014-08-12: adding R server for Aran,
# this should really go into its own VM
RUN apt-get install -y --no-install-recommends r-base 
RUN apt-get install -y --no-install-recommends r-base-dev 

RUN apt-get install -y dnsutils


# lively
ENV WORKSPACE_LK /home/lively/LivelyKernel
ENV HOME /home/lively
ENV livelyport 9001
USER lively

WORKDIR /home/lively/LivelyKernel

EXPOSE 9001
EXPOSE 9002
EXPOSE 9003
EXPOSE 9004

CMD rm *.pid; \
    node bin/lk-server -p 9001 --behind-proxy
