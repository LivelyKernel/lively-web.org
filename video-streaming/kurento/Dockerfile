FROM ubuntu:14.04

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# basics
# -=-=-=-

USER root
ENV DEBIAN_FRONTEND=noninteractive
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y curl wget lsof dnsutils htop man less openssl && \
  apt-get install -y sudo aspell unzip zip git emacs && \
  apt-get install -y python python-dev python-pip python-virtualenv && \
  rm -rf /var/lib/apt/lists/*

# nodejs
RUN \
  cd /tmp && \
  wget http://nodejs.org/dist/node-latest.tar.gz && \
  tar xvzf node-latest.tar.gz && \
  rm -f node-latest.tar.gz && \
  cd node-v* && \
  ./configure && \
  CXX="g++ -Wno-unused-local-typedefs" make && \
  CXX="g++ -Wno-unused-local-typedefs" sudo make install && \
  cd /tmp && \
  rm -rf /tmp/node-v* && \
  npm install -g npm && npm install forever -g

# gstreamer
Run yes | add-apt-repository ppa:gstreamer-developers/ppa && \
    apt-get update && \
    apt-get -y install gstreamer1.0*

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# kurento
RUN sudo apt-get install -y software-properties-common && \ 
    yes | sudo add-apt-repository ppa:kurento/kurento && \
    yes | sudo apt-add-repository http://ubuntu.kurento.org && \
    wget -O - http://ubuntu.kurento.org/kurento.gpg.key | sudo apt-key add - && \
    sudo apt-get update && \
    sudo apt-get install -y kurento-media-server

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# user
# -=-=-
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN /usr/sbin/useradd \
    --create-home --home-dir /home/kurento \
     --shell /bin/bash \
     --groups sudo \
     --password $(openssl passwd -1 "kurento") \
     kurento

ENV HOME=/home/kurento
USER kurento
WORKDIR /home/kurento/
ENV PATH=$HOME/bin:$PATH

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# lively / cloxp
# -=-=-=-=-=-=-=-
# java...!
USER root
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee -a /etc/apt/sources.list; \
    echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee -a /etc/apt/sources.list; \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886; \
    apt-get update
# auto accept oracle jdk license
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections; \
    apt-get install -y oracle-java8-installer ca-certificates
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
USER kurento

# leiningen
RUN sudo apt-get -y install maven;
RUN mkdir -p $HOME/bin; \
    cd $HOME/bin; \
    wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein; \
    chmod a+x lein; \
    ./lein

# cloxp
RUN git clone https://github.com/cloxp/cloxp-install && \
    cd cloxp-install && \
    ./install.sh && \
    mv LivelyKernel ../ && \
    cd .. && \
    rm -rf cloxp-install;

# lively
ENV WORKSPACE_LK=/home/kurento/LivelyKernel

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

# Define default command.
CMD ["bash"]
