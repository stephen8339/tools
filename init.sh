#!/bin/sh
if [ "$1" = "" ];then
echo "ERROR: Please Enter Server Hostname!"
else
    /data/tools/centos6.sh
    echo "127.0.0.1 $1" > /etc/hosts
    cat /etc/sysconfig/network | sed "s/HOSTNAME=\([0-9]\{1,3\}\-\)\{3\}[0-9]\{1,3\}/HOSTNAME=$1/g" -i /etc/sysconfig/network
    cp /data/tools/authorized_keys /root/.ssh/
    echo "Port 3321" >> /etc/ssh/sshd_config
    echo "Port 3321" >> /etc/ssh/ssh_config
    cat /etc/ssh/sshd_config | sed "s/PasswordAuthentication yes/PasswordAuthentication no/g" -i /etc/ssh/sshd_config
    service sshd restart
    cp /data/tools/jdk-7u25-linux-x64.gz /root/
    /data/tools/java_install.sh
    mkdir -p /data/server/build /data/server/target
    yum install -y rsync
    reboot now
fi
