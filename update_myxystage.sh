#!/bin/bash
#cd /data/server
#git pull
#/data/shell/createcfg.sh
#/data/shell/rsync_server.sh
/data/tools/myxystagetag.sh
source /data/tools/myxytagnew
echo $tag
cd /data/server
git pull
git fetch --all
git checkout cn_fl_appstore_$tag
git pull
make stop
make
make deploy
