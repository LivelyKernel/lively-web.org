FROM          dockerfile/nodejs
MAINTAINER    Robert Krahn <robert.krahn@gmail.com>

USER root
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y \
    python-software-properties \
    curl wget git \
    less manpages manpages-dev \
    openssh-server openssh-client sudo \
    lsof dnsutils aspell bzip2 unzip zip

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# java...!
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee -a /etc/apt/sources.list
RUN echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee -a /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
RUN apt-get update

# auto accept oracle jdk license
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java8-installer ca-certificates

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

RUN apt-get -y install maven

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

RUN /usr/sbin/useradd \
    --create-home --home-dir /home/lively \
     --shell /bin/bash \
     --groups sudo \
     --password niHEcdDiD3J1o \
     lively

# git
ADD gitconfig /home/lively/.gitconfig

# nodejs tooling
RUN npm install forever -g

# lively
ENV WORKSPACE_LK /home/lively/cloxp/LivelyKernel
ENV HOME /home/lively
USER lively

ADD gitconfig /home/lively/.gitconfig

RUN mkdir /home/lively/bin
ENV PATH $HOME/bin:$PATH

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

WORKDIR /home/lively/cloxp/LivelyKernel

# default clojure nREPL port
# + Lively runs here
EXPOSE 10080

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# cloxp specific workspace setup

RUN mkdir -p /home/lively/bin; \
    cd /home/lively/bin; \
    wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein; \
    chmod a+x lein; \
    ./lein

CMD rm *.pid; \
    forever bin/lk-server.js -p 10080
