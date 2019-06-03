#!/bin/bash
#Credits : https://share.zabbix.com/atc/pbx/asterisk-template
#Modifié par Humbert

PATH="$(env |grep "^PATH" |cut -f2 -d"=")"


#MS=$(sudo /usr/sbin/asterisk -rx "sip show peers" | grep OK | grep -oP '\(\K[^\)]+' | sed 's/ms//g' | sort -n | awk '$1>199')
MS=$(sudo /usr/sbin/asterisk -rx "sip show peers" | grep OK | grep -oP "([0-9]* ms)" | sed 's/ ms//g' | sort -n | awk '$1>199')

LOG=$(for i in $(sudo /usr/sbin/asterisk -rx "sip show peers" | grep OK | grep -oP '([0-9]* ms)' | sed 's/ ms//g' | sort -n | awk '$1>199'); do sudo /usr/sbin/asterisk -rx "sip show peers" | grep OK | grep $i; done)
DATE=$(date +"%m-%d-%y %H:%M:%S")


if [[ -n "$MS" ]];
 then 
 	echo $DATE  "the problematic exts are : " $LOG>> /var/log/messages_lag
	tail -1 /var/log/messages_lag | grep -oP '[0-9a-zA-Z]*/[0-9a-zA-Z]*' | grep -oP '[0-9a-zA-Z]*/' | grep -oP '[0-9a-zA-Z]*'
fi
