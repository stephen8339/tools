#!/bin/bash
yum install gcc -y

groupadd zabbix

useradd -g zabbix -s /sbin/nologin zabbix

cd /data/tools

tar -zxvf /data/tools/zabbix-2.4.5.tar.gz

cd zabbix-2.4.5

./configure --prefix=/data/zabbix --enable-agent

make

make install

echo "zabbix-agent   10050/tcp   #zabbixagent" >>/etc/services

cat /data/tools/zabbix-2.4.5/misc/init.d/fedora/core/zabbix_agentd | sed 's/BASEDIR\=\/usr\/local/BASEDIR\=\/data\/zabbix/g' -i /data/tools/zabbix-2.4.5/misc/init.d/fedora/core/zabbix_agentd

cp /data/tools/zabbix-2.4.5/misc/init.d/fedora/core/zabbix_agentd /etc/init.d/

cat /data/zabbix/etc/zabbix_agent.conf | sed 's/127\.0\.0\.1/10\.6\.16\.3/g' -i /data/zabbix/etc/zabbix_agent.conf

cat /data/zabbix/etc/zabbix_agentd.conf | sed 's/127\.0\.0\.1/10\.6\.16\.3/g' -i /data/zabbix/etc/zabbix_agentd.conf

read -p "Enter Server Name:" servername

cat /data/zabbix/etc/zabbix_agentd.conf | sed "s/\bHostname=.*\b/Hostname=$servername/g" -i /data/zabbix/etc/zabbix_agentd.conf

/etc/init.d/zabbix_agentd start
