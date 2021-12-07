#!/bin/bash
if [ $# -lt 1 ];then
	echo "$0 needs input as list of services to be restarted"
	exit 1
else
	ser=$1
fi

CHECK()
{
	if [ $? -ne 0 ];then
		echo "last command is not success..exiting"
	fi
}


sudo systemctl daemon-reload
CHECK
sudo systemctl restart $ser
CHECK
sudo systemctl status $ser
