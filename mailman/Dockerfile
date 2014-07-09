FROM          debian:7.4
MAINTAINER    Robert Krahn <robert.krahn@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get -y install mailman apache2 postfix

RUN /etc/init.d/mailman stop
ADD mailman-apache.conf /etc/apache2/sites-available/mailman
ADD mm_cfg.py /etc/mailman/mm_cfg.py
RUN usermod -G www-data list
RUN cd /var/lib/mailman/bin && ./genaliases
RUN chown -R list:www-data /var/lib/mailman/logs/; \
    chmod -R g+rw /var/lib/mailman/data; \
    chown -R list:list /var/lock/mailman; \
    chmod a+xrw /var/lib/mailman/locks/
RUN /etc/init.d/mailman start

ADD postfix-transport /etc/postfix/transport
RUN postconf -e 'transport_maps = hash:/etc/postfix/transport'
RUN postmap -v /etc/postfix/transport
RUN /etc/init.d/postfix restart

RUN mkdir -p /var/www/lists
RUN a2ensite mailman
RUN /etc/init.d/apache2 stop
#RUN /etc/init.d/apache2 restart

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data

EXPOSE 80
EXPOSE 25

CMD service mailman start; \
    service apache2 start; \
    /bin/bash