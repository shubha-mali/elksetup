#!/bin/bash

export ES_HOME="/usr/share/elasticsearch/bin"
export ES_CONF="/etc/elasticsearch"
export KIBANA_CONF="/etc/kibana/config"
export LG_CONF="/etc/logstash/config"

export instance_file="/tmp/instance.yml"

if [ ! -f $instance_file ];then
	echo "instance file not found !"
	exit 1
fi

mkdir -p /tmp/elk_cert
cd $ES_HOME
elasticsearch-certutil cert --keep-ca-key --pem --in instance_file --out ~/tmp/elk_cert/certs.zip

cd tmp
unzip certs.zip -d ./certs


mkdir -p $ES_CONF/certs
mkdir -p $KIBANA_CONF/certs
mkdir -p $LG_CONF/certs

## copy certs to individual config
cp ~/tmp/certs/ca/ca* ~/tmp/certs/es1/* $ES_CONF/certs
cp ~/tmp/certs/ca/ca* ~/tmp/certs/es1/* $KIBANA_CONF/certs
cp ~/tmp/certs/ca/ca* ~/tmp/certs/es1/* $LG_CONF/certs

### update logstash.key to PKCS#8 format for Beats input plugin
cd $LG_CONF
openssl pkcs8 -in certs/logstash.key -topk8 -nocrypt -out certs/logstash.pkcs8.key


