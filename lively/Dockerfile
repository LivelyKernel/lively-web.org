FROM          dockerfile/nodejs
MAINTAINER    Robert Krahn <robert.krahn@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get -y install curl git bzip2 unzip
RUN apt-get install lsof

# lively user
RUN /usr/sbin/useradd --create-home --home-dir /home/lively --shell /bin/bash lively

# nodejs tooling
RUN npm install -g node-inspector
RUN npm install forever -g

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
    npm start
