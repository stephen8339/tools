#!/bin/sh

PID="$(ps aux|grep server.jar|awk '{print $2}'|sed -n '1p')"
cat /proc/$PID/limits

