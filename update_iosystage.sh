#!/bin/bash
#cd /data/server
#git pull
#/data/shell/createcfg.sh
#/data/shell/rsync_server.sh
/data/tools/iosystagetag.sh
source /data/tools/iytagnew
echo $tag
cd /data/server
git pull
git fetch --all
git checkout cn_yueyu_$tag
git pull
make stop
make
make deploy
