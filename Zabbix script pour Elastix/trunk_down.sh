#!/bin/bash
#Credits : https://share.zabbix.com/atc/pbx/asterisk-template
#Modifié par Humbert.

PATH="$(env |grep "^PATH" |cut -f2 -d"=")"

TRUNK=$(sudo /usr/sbin/asterisk -rx "sip show peers" | grep UNREACHABLE | grep -I SBC01_INi\/TechITElastix | awk '{print$1}'| grep [A-Za-z])

if [ -n "$TRUNK" ]
then
	echo $TRUNK
else
	echo "0"
fi 




# /home/zabbix/trunk_down.sh





