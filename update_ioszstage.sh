#!/bin/bash
#cd /data/server
#git pull
#/data/shell/createcfg.sh
#/data/shell/rsync_server.sh
/data/tools/ioszstagetag.sh
source /data/tools/iztagnew
echo $tag
cd /data/server
git pull
git fetch --all
git checkout cn_appstore_$tag
git pull
make stop
make
make deploy
