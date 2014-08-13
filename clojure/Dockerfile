FROM    lively-web-server
MAINTAINER Robert Krahn "robert.krahn@gmail.com"

USER root
RUN apt-get update
RUN apt-get install -y \
    python-software-properties \
    curl wget git \
    less manpages manpages-dev \
    openssh-server openssh-client sudo \
    lsof
RUN apt-get -y install openjdk-7-jre-headless

# RUN apt-get -y install supervisor
# RUN mkdir -p /var/log/supervisor
# ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

USER lively
RUN mkdir -p $HOME/bin/; \
    cd $HOME/bin/; \
    wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein; \
    chmod 0755 $HOME/bin/lein; \
    $HOME/bin/lein upgrade;

ADD profiles.clj $HOME/.lein/profiles.clj

ENV PATH $HOME/bin:$PATH

EXPOSE 9080
EXPOSE 9081
EXPOSE 9082
EXPOSE 9083
EXPOSE 9084

USER root
RUN usermod -p niHEcdDiD3J1o lively
USER lively

CMD rm *.pid; \
    node bin/lk-server -p 9080
# --behind-proxy
# CMD ["/usr/bin/supervisord"]
