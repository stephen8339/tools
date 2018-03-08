#!/bin/sh
curl -L https://td-toolbelt.herokuapp.com/sh/install-redhat-td-agent2.sh | sh
rm -rf /etc/td-agent/td-agent.conf
cp /data/tools/td-agent.conf /etc/td-agent/
chmod 777 -R /data/log
service td-agent restart
