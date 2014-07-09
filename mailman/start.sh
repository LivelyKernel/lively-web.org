#!/bin/bash                                                                                                                            

cd /home/lively/lively-web.org/mailman

mailman_data=$HOME/lively-web.org/data/var-lib-mailman
container_name=lively-web-mailman

#docker build --rm -t $container_name .

# if [ -z "$(docker ps -a | grep $container_name)" ]; then
#   docker build --rm -t $container_name .
# fi

sudo find $mailman_data/mailman/lists/ -iname config.pck -exec chgrp www-data {} \;
sudo find $mailman_data/mailman/lists/ -maxdepth 1 -type d -exec chmod a+rwx {} \;

docker run \
  -e RELAY_DOMAINS=lists.lively-web.org \
  -e MAILMAN_DOMAIN=lists.lively-web.org \
  -p 25:25 -p 8081:80 \
  -v "$mailman_data/mailman/archives":/var/lib/mailman/archives \
  -v "$mailman_data/mailman/lists":/var/lib/mailman/lists \
  -v "$mailman_data/mailman/data":/var/lib/mailman/data \
  -h lists.lively-web.org \
  -i -t $container_name

#  -v "$PWD/var-lib-mailman/mailman":/var/lib/mailman \
# -d \
# find /var/lib/mailman/lists/ -iname config.pck -exec chgrp www-data {} \;
# chown list:list /var/lib/mailman/lists/mailman/config.pck
# service mailman start
# service apache2 start
