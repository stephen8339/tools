start-sdk:
	@/data/tomcat/bin/startup.sh
	@sleep 1
	netstat -anp | grep 80

start-cross:
	@mkdir -p /data/log
	@- rm -rf /data/server/target
	@cp -aR /data/server/build/target /data/server
	@nohup java -Djava.rmi.server.hostname=10.6.15.36 -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=10003 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -server -Xms4G -Xmx4G -XX:+UseG1GC -XX:MaxGCPauseMillis=50 -XX:GCPauseIntervalMillis=200 -jar -Dapp.dir="/data/server/target/" /data/server/target/server.jar crossrealm 0<&- &>1 &
	@sleep 1
	@sleep 1
	@sleep 1
	@sleep 1
	@sleep 1
	@sleep 1
	@sleep 1
	@sleep 1
	cat /data/log/crossrealm.pid
	ps aux | grep java

start-logic:
	@mkdir -p /data/log
	@- rm -rf /data/server/target
	@cp -aR /data/server/build/target /data/server
	@nohup java -Djava.rmi.server.hostname=10.6.15.36 -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=10004 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -server -Xms10G -Xmx10G -XX:PermSize=256m -XX:MaxPermSize=512m -XX:NewRatio=1 -XX:+UseG1GC -XX:MaxGCPauseMillis=50 -XX:GCPauseIntervalMillis=200 -jar  -Dapp.dir="/data/server/target/" /data/server/target/server.jar logic 0<&- &>1 &
	@sleep 1
	@sleep 1
	@sleep 1
	@sleep 1
	@sleep 1
	@sleep 1
	@sleep 1
	@sleep 1
	netstat -anp | grep -E "(Recv-Q|8887|8888)"
	
start-pvp:
	@mkdir -p /data/log
	@- rm -rf /data/server/target
	@cp -aR /data/server/build/target /data/server
	@nohup java -Djava.rmi.server.hostname=10.6.15.36 -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=10005 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -server -Xms2G -Xmx2G -XX:+UseG1GC -XX:MaxGCPauseMillis=50 -XX:GCPauseIntervalMillis=200 -jar  -Dapp.dir="/data/server/target/" /data/server/target/server.jar pvp 0<&- &>1 &
	@sleep 1
	@sleep 1
	@sleep 1
	@sleep 1
	@sleep 1
	@sleep 1
	@sleep 1
	@sleep 1
	cat /data/log/match.pid
	ps aux | grep java
	
stop-sdk:
	@/data/tomcat/bin/shutdown.sh
	@rm -rf /data/tomcat/webapps/ROOT

stop-logic:
	kill  `cat /data/log/logic.pid`
	sleep 10
	- kill -9 `cat /data/log/logic.pid`
	- ./clredislogic.sh
	@sleep 1

stop-cross:
	kill  `cat /data/log/crossrealm.pid`
	@sleep 1

stop-pvp:
	kill  `cat /data/log/match.pid`
	@sleep 1
	
restart-sdk:
	@/data/tomcat/bin/shutdown.sh
	@rm -rf /data/tomcat/webapps/ROOT
	@/data/tomcat/bin/startup.sh
	@sleep 1
	netstat -anp | grep 80

restart-logic:
	kill  `cat /data/log/logic.pid`
	sleep 10
	- kill -9 `cat /data/log/logic.pid`
	@- ./clredislogic.sh
	@sleep 1
	@- rm -rf /data/server/target
	@cp -aR /data/server/build/target /data/server
	@nohup java -Djava.rmi.server.hostname=10.6.15.36 -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=10004 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -server -Xms10G -Xmx10G -XX:PermSize=256m -XX:MaxPermSize=512m -XX:NewRatio=1 -XX:+UseG1GC -XX:MaxGCPauseMillis=50 -XX:GCPauseIntervalMillis=200 -jar  -Dapp.dir="/data/server/target/" /data/server/target/server.jar logic 0<&- &>1 &
	@sleep 1
	@sleep 1
	@sleep 1
	@sleep 1
	@sleep 1
	@sleep 1
	@sleep 1
	@sleep 1
	netstat -anp | grep -E "(Recv-Q|8887|8888)"
	
restart-cross:
	kill  `cat /data/log/crossrealm.pid`
	@sleep 1
	@- rm -rf /data/server/target
	@cp -aR /data/server/build/target /data/server
	@nohup java -Djava.rmi.server.hostname=10.6.15.36 -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=10003 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -server -Xms4G -Xmx4G -XX:+UseG1GC -XX:MaxGCPauseMillis=50 -XX:GCPauseIntervalMillis=200 -jar  -Dapp.dir="/data/server/target/" /data/server/target/server.jar crossrealm 0<&- &>1 &
	@sleep 1
	@sleep 1
	@sleep 1
	@sleep 1
	@sleep 1
	@sleep 1
	@sleep 1
	@sleep 1
	cat /data/log/crossrealm.pid
	ps aux | grep java

restart-pvp:
	kill  `cat /data/log/match.pid`
	@sleep 1
	@- rm -rf /data/server/target
	@cp -aR /data/server/build/target /data/server
	@nohup java -Djava.rmi.server.hostname=10.6.15.36 -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=10005 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -server -Xms2G -Xmx2G -XX:+UseG1GC -XX:MaxGCPauseMillis=50 -XX:GCPauseIntervalMillis=200 -jar  -Dapp.dir="/data/server/target/" /data/server/target/server.jar pvp 0<&- &>1 &
	@sleep 1
	@sleep 1
	@sleep 1
	@sleep 1
	@sleep 1
	@sleep 1
	@sleep 1
	@sleep 1
	cat /data/log/match.pid
	ps aux | grep java

stop_in_server:
	@killall java

clear_redis:
	./clredisshare.sh

check:
	netstat -anp | grep -E "(Recv-Q|80|8080|8887|8888|8880|8881)"

