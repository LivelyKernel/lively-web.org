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

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# user
# -=-=-

RUN /usr/sbin/useradd \
    --create-home --home-dir /home/janus \
     --shell /bin/bash \
     --groups sudo \
     --password $(openssl passwd -1 "janus") \
     janus

ENV HOME=/home/janus
USER janus
WORKDIR /home/janus/

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# Lively + nodejs tooling
# -=-=-=-=-=-=-=-=-=-=-=-=-
RUN printf '\n# Node.js\nexport PATH="node_modules/.bin:$PATH"' >> /home/janus/.bashrc && \
    git clone https://github.com/LivelyKernel/LivelyKernel --branch master --single-branch && \
    cd LivelyKernel && npm install

ENV WORKSPACE_LK=/home/janus/LivelyKernel

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# personal stuff
# -=-=-=-=-=-=-=-
ADD gitconfig /home/janus/.gitconfig
RUN mkdir /home/janus/bin
ENV PATH=$HOME/bin:$PATH

EXPOSE 9001 9002 9003 9004 9005 9300 9301 9302 9303 9304 9405 9306 9307 9308 9309

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# janus webrtc gateway
# -=-=-=-=-=-=-=-=-=-=-
USER root
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER janus

RUN sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe restricted multiverse" && \
    sudo apt-get update

RUN sudo apt-get install -y libmicrohttpd-dev libjansson-dev libnice-dev \
     libssl-dev libsrtp-dev libsofia-sip-ua-dev libglib2.0-dev \
     libopus-dev libogg-dev libini-config-dev libcollection-dev \
     pkg-config gengetopt libtool automake \
     subversion cmake

# data channel support (optional)
RUN svn co http://sctp-refimpl.googlecode.com/svn/trunk/KERN/usrsctp usrsctp; \
   cd usrsctp; \
   ./bootstrap; \
   ./configure --prefix=/usr && make && sudo make install

# websock support, optional
RUN git clone git://git.libwebsockets.org/libwebsockets && \
   cd libwebsockets && \
   mkdir build && \
   cd build && \
   cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr .. && \
   make && sudo make install;

# build it
RUN git clone https://github.com/meetecho/janus-gateway.git && \
   cd janus-gateway && \
   sh autogen.sh && \
   ./configure --disable-docs --disable-rabbitmq && \
   make && \
   sudo make install && \
   sudo make configs

# gstreamer
Run yes | sudo add-apt-repository ppa:gstreamer-developers/ppa && \
    sudo apt-get update && \
    sudo apt-get -y install gstreamer1.0*

# Define default command.
CMD ["bash"]