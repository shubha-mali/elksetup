#!/bin/bash
if [ $# -lt 1 ];then
	echo "$0 needs input as list of services to be installed"
	exit 1
else
	services=$1
fi

mkdir -p elk_install
cd elk_install

CHECK()
{
	if [ $? -ne 0 ];then
		echo "last command is not success..exiting"
	fi
}

# install jdk8+
java_check()
{
java_ver=`java -version 2>&1 >/dev/null | grep 'java version' | awk '{print $3}' | sed -e 's/"//g'`
if [ ` echo $java_ver | grep '1.8'` ];then
	echo "java version is greater than 8, no change needed"
else
	echo "java version is less than 8, installing latest.."
	sudo apt-get update
	sudo apt-get install default-jre
	CHECK
}	



# install rpms
install_es()
{
	sudo wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.15.2-x86_64.rpm
	CHECK
	sudo rpm -ivh elasticsearch-7.9.2-x86_64.rpm
	CHECK
	sudo systemctl enable elasticsearch
	CHECK
}

install_kibana()
{
	sudo wget https://artifacts.elastic.co/downloads/kibana/kibana-7.15.2-x86_64.rpm
	CHECK
	sudo rpm -ivh kibana-7.15.2-x86_64.rpm
	CHECK
	sudo systemctl enable kibana
	CHECK
}

install_lg()
{
	sudo wget https://artifacts.elastic.co/downloads/logstash/logstash-7.15.2-x86_64.rpm
	CHECK
	sudo rpm -ivh logstash-7.15.2-x86_64.rpm
	CHECK
	sudo systemctl enable logstash
	CHECK
	sudo /opt/logstash/bin/logstash-plugin install logstash-input-beats
}


## MAIN ###
java_check
install_es
install_kibana
install_lg
