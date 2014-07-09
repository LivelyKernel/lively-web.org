#!/bin/bash

rsync --progress -vzae 'ssh' \
    lively@LivelyBackupMacMini.att.net:/Volumes/BackupDisk/backups/lively-web/current/var/lib/mailman \
    var-lib-mailman

rsync -e "ssh" -avz --progress lively@lively-web.org:/var/www/lists var-www-lists

VBoxManage controlvm boot2docker-vm natpf1 "lively-server,tcp,127.0.0.1,8080,,8080"

docker build --rm -t lively-web-mailman .
