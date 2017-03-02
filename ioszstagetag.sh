#!/bin/sh
cd /data/server
git pull
git tag | grep cn_appstore_ | sed 's/cn_appstore_//g' > /data/tools/iztags
echo "#!/bin/sh" > /data/tools/iztagnew
echo -n "tag=" >> /data/tools/iztagnew
awk -F . '{print $1*1000000+$2*10000+$3*100+$4,$0}' /data/tools/iztags | sort -n -k 1 | awk '{print $2}' | tail -1>> /data/tools/iztagnew
