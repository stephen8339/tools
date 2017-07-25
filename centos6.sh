#!/bin/bash
iptable ipv6
#------------------------------------------------------------------
echo 'alias net-pf-10 off' >> /etc/modprobe.conf
echo 'alias ipv6 off' >> /etc/modprobe.conf
echo 'options ipv6 disable=1' >> /etc/modprobe.conf
chkconfig ip6tables off

# disable selinux
#------------------------------------------------------------------
setenforce 0
sed -i '/SELINUX=enforcing/ s/enforcing/disabled/g' /etc/selinux/config

#disable sudoer tty
cat /etc/sudoers |sed 's/Defaults\s\{1,10\}requiretty/#Defaults??? requiretty/g' -i /etc/sudoers

# disable services
#------------------------------------------------------------------
for i in `ls /etc/rc3.d/S*`
do
CURSRV=`echo $i|cut -c 15-`
case $CURSRV in
ntpd | readahead_early | iscsid | iptables | mcstrans | network | auditd | restorecond | cpuspeed | irqbalance | iscsi | portmap | acpid | lvm2-monitor | sshd | gpm | crond | anacron | atd | yum-updatesd | local | smartd | syslog)
echo "$CURSRV: Base services, Skip!"
;;
*)
echo "change $CURSRV to off"
chkconfig $CURSRV off
service $CURSRV stop
;;
esac
done

# set ntp
#------------------------------------------------------------------
#if [ -f ./boserver/tools/ntp-4.2.2p1-15.el5.centos.1.x86_64.rpm ];then
#??? rpm -ivh ./boserver/tools/ntp-4.2.2p1-15.el5.centos.1.x86_64.rpm
#else
#??? exit 3
#fi
#sed -i '/^server.*centos/ s/^/#/' /etc/ntp.conf
#echo "server $NTPSVR" >> /etc/ntp.conf
chkconfig ntpd on
#ntpdate $NTPSVR
/etc/init.d/ntpd start

#yum install -y ntp
#echo '0 * * * * ntpdate -s 114.80.81.1 > /dev/null 2>&1' >> /var/spool/cron/root

# set env
#------------------------------------------------------------------
echo 'HISTSIZE=100' >> /etc/profile
echo 'export TMOUT=1800' >> /etc/profile
echo 'ulimit -n 51200' >> /etc/profile
echo "PS1='[\u@\h \w]#'" >> /etc/bashrc
echo "alias ls='ls -A --color=tty'" >> /etc/bashrc

# set local
#------------------------------------------------------------------
echo 'LC_CTYPE="zh_CN.UTF-8"' >> /etc/sysconfig/i18n

# set wheel
#------------------------------------------------------------------
#sed -i '/pam_wheel.so use_uid/ s/#//' /etc/pam.d/su
#echo 'auth required pam_wheel.so use_uid' >> /etc/pam.d/su
#echo 'SU_WHEEL_ONLY yes' >> /etc/login.defs
#gpasswd -M liusong wheel

# set tty
#------------------------------------------------------------------
sed -i '/3:2345:.*tty3/ s/^/#/' /etc/inittab
sed -i '/4:2345:.*tty4/ s/^/#/' /etc/inittab
sed -i '/5:2345:.*tty5/ s/^/#/' /etc/inittab
sed -i '/6:2345:.*tty6/ s/^/#/' /etc/inittab
sed -i '/ctrlaltdel/ s/^/#/' /etc/inittab
init q

# set ulimit??? £¨Î¼þ¾ä£©
#------------------------------------------------------------------
ulimit -SHn 51200
echo '* soft nofile 51200' >> /etc/security/limits.conf
echo '* hard nofile 51200' >> /etc/security/limits.conf
echo 'session required pam_limits.so' >> /etc/pam.d/login

# set sysctl?????? £¨TCP\IPl½Óý¢°²ȫ£©
#------------------------------------------------------------------
echo 'net.ipv4.tcp_fin_timeout = 30' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_keepalive_time = 1800' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_syncookies = 1' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_tw_reuse = 1' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_tw_recycle = 1' >> /etc/sysctl.conf
echo 'net.ipv4.ip_local_port_range = 1024 65000' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_max_syn_backlog = 8192' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_max_tw_buckets = 4096' >> /etc/sysctl.conf
sysctl -p

#rps up
#------------------------------------------------------------------
for file in $(ls /sys/class/net/eth*/queues/rx-*/rps_cpus)
do
        echo f > $file
done

for file in $(ls /sys/class/net/eth*/queues/rx-*/rps_flow_cnt)
do
        echo 65536 > $file
done

if [ $(ls /sys/class/net/|grep -c nic) -ne 0 ]; then
        for file in $(ls /sys/class/net/nic*/queues/rx-*/rps_cpus)
        do
                echo f > $file
        done

        for file in $(ls /sys/class/net/nic*/queues/rx-*/rps_flow_cnt)
        do
                echo 65536 > $file
        done
fi

