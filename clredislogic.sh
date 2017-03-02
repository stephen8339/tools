#!/bin/bash
rm -rf redis.properties
cp /data/server/target/conf/logic/redis.properties /data/tools
. ./redis.properties
(sleep 3;echo "flushdb $db";\sleep 3)|telnet $host $port
