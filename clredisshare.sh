#!/bin/bash
rm -rf redis_shared.properties
cp /data/server/target/conf/logic/redis_shared.properties /data/tools
. ./redis_shared.properties
(sleep 3;echo "flushall";\sleep 3)|telnet $host $port
