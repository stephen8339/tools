#!/bin/sh
cd /data/server
git pull
git tag | grep cn_yueyu_ | sed 's/cn_yueyu_//g' > /data/tools/iytags
echo "#!/bin/sh" > /data/tools/iytagnew
echo -n "tag=" >> /data/tools/iytagnew
awk -F . '{print $1*1000000+$2*10000+$3*100+$4,$0}' /data/tools/iytags | sort -n -k 1 | awk '{print $2}' | tail -1>> /data/tools/iytagnew
