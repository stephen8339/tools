#!/bin/sh
#安装jdk

mkdir -p /usr/lib/jvm

tar zxvf ~/jdk-7u25-linux-x64.gz -C /usr/lib/jvm
mv /usr/lib/jvm/jdk1.7.0_25 /usr/lib/jvm/jdk1.7.0
echo "export JAVA_HOME=/usr/lib/jvm/jdk1.7.0" >> ~/.bashrc
source ~/.bashrc
echo "export JRE_HOME=${JAVA_HOME}/jre" >> ~/.bashrc
source ~/.bashrc
echo "export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib" >> ~/.bashrc
echo "export PATH=${JAVA_HOME}/bin:$PATH" >> ~/.bashrc

source ~/.bashrc
update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.7.0/bin/java 300
update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.7.0/bin/javac 300
update-alternatives --install /usr/bin/jar jar /usr/lib/jvm/jdk1.7.0/bin/jar 300
update-alternatives --auto java

version=$(java -version)
echo $version

