#!/bin/bash
touch /data/tools/tmpip.sh
touch /data/tools/meminfo.sh
echo "#!/bin/bash" > /data/tools/tmpip.sh
echo "#!/bin/bash" > /data/tools/meminfo.sh
echo -n "a=">> /data/tools/tmpip.sh
echo -n "b=">> /data/tools/meminfo.sh
/sbin/ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:" >> /data/tools/tmpip.sh
awk '/MemTotal/{total=$2}END{print(total*0.6/1000/1000)}' /proc/meminfo | cut -d . -f 1 >> /data/tools/meminfo.sh
source /data/tools/tmpip.sh
source /data/tools/meminfo.sh
cat /data/tools/Makefile | sed "s/Djava.rmi.server.hostname=\([0-9]\{1,3\}\.\)\{3\}[0-9]\{1,3\}/Djava.rmi.server.hostname=$a/g" -i /data/tools/Makefile
cat /data/tools/Makefile | sed "s/Xms[0-9]\{1,2\}G/Xms$b\G/g" -i /data/tools/Makefile
cat /data/tools/Makefile | sed "s/Xmx[0-9]\{1,2\}G/Xmx$b\G/g" -i /data/tools/Makefile
rm -rf /data/tools/tmpip.sh
rm -rf /data/tools/meminfo.sh
