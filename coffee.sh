#!/bin/bash
obsidian_nginx=/data/server/scripts/nginx
NGINX_PORT=8889
LOGIC_HOST=127.0.0.1
LOGIC_PORT=8888
KEY=obsidian
PID_FILE=/data/log/nginx.pid
coffee $obsidian_nginx/master.coffee $NGINX_PORT $LOGIC_HOST $LOGIC_PORT $KEY $PID_FILE
