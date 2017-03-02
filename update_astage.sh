#!/bin/bash
#cd /data/server
#git pull
#/data/shell/createcfg.sh
#/data/shell/rsync_server.sh
/data/tools/astagetag.sh
source /data/tools/atagnew
echo $tag
cd /data/server
git pull
git fetch --all
git checkout cn_android_$tag
git pull
make stop
make
make deploy
