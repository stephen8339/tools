#!/bin/bash
SRC=/data/log
DST=/data/logfile/sdk
HOST=gmt
USR=root
inotifywait -mrqs --timefmt '%d/%m/%y %H:%M' --format '%T %w%f' -e modify,delete,create,attrib $SRC | while read DATE TIME DIR FILE
do
rsync -avzthP --delete $SRC $USR@$HOST:$DST 
echo "${files} was rsynced" >> /var/log/rsync.log 2>&1
done
