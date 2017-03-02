#!/bin/sh
cd /data/server
git pull
git tag | grep cn_android_ | sed 's/cn_android_//g' > /data/tools/atags
echo "#!/bin/sh" > /data/tools/atagnew
echo -n "tag=" >> /data/tools/atagnew
awk -F . '{print $1*1000000+$2*10000+$3*100+$4,$0}' /data/tools/atags | sort -n -k 1 | awk '{print $2}' | tail -1>> /data/tools/atagnew
