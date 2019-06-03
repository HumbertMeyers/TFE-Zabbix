#!/bin/bash
#Credits : https://share.zabbix.com/atc/pbx/asterisk-template

if [ "$(sudo -u root fail2ban-client ping |grep -o "pong")" == "pong" ]
then
	echo "1"
else
	echo "0"
fi

