Setup :
 Cluster of 3 Elasticsearch nodes
 1 Logstash node
	Logstash listening on TCP port 5042
	Logstash can write to Elasticsearch
1 Kibana node
	Kibana listening on a public interface
	Kibana can read from Elasticsearch

------------------------------------------------------------------------------------
pre-requisites checks
	- verify the installation user has sudo access
	- verify the server has enough space
	- verify the server has enough memory & resource befor install

-----------------------------------------------------------------------------------
Steps:
1. Install ELK stack
	- download and run below script for installation on respective nodes 
		elk_rpm_install_node1.sh ( 1 ES , 1 kibana, 1 logstash)
		elk_rpm_install_node2.sh  ( 1 ES)
		elk_rpm_install_node3.sh  (1 ES)
2. configure the ELK stack (manual steps)
	- follow the instructions from elk_configuration.txt to perform required configuration
3. restart ELK stack components and verify the system is up properly 
	- elk_service_restart.sh
	- verify logs of each component
	- verify the url access for all components
4. setup nginx for kibana access 
	- setup_nginx_for_kibana.sh
	- verify the url access for kibana
5. configure TLS on ELK stack
	- place the instance.yaml in /tmp on node1
	- create_cert.sh
	- follow manual instructions from configure_certs.txt to update the configuration for adding certs
	- verify the url access for all components
6. backups 
	- read backups.txt for instructions
