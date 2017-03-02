#!/bin/sh
cd /data/server
git pull
git tag | grep cn_fl_appstore_ | sed 's/cn_fl_appstore_//g' > /data/tools/myxytags
echo "#!/bin/sh" > /data/tools/myxytagnew
echo -n "tag=" >> /data/tools/myxytagnew
awk -F . '{print $1*1000000+$2*10000+$3+$4,$0}' /data/tools/myxytags | sort -n -k 1 | awk '{print $2}' | tail -1>> /data/tools/myxytagnew
