#!/bin/bash
#Credits : https://share.zabbix.com/atc/pbx/asterisk-template
#Modifié par Humbert.

CHANNEL="$(sudo /usr/sbin/asterisk -rx 'core show channels concise' |cut -f12,1 -d'!' |sed 's/!/ /g' |sort -n -k 2 |tail -1)"
CHANNEL_NAME=$(echo $CHANNEL |awk '{print$1}')
CHANNEL_TIME=$(echo $CHANNEL |awk '{print$2}')

if [ -z "$CHANNEL_TIME" ]
then
	CHANNEL_TIME=0
fi

if [ "$CHANNEL_TIME" -gt "9600" ]
then
	sudo /usr/sbin/asterisk -rx "channel request hangup $CHANNEL_NAME" >> /tmp/hangup.txt
	sleep 1
	if [ "$(sudo /usr/sbin/asterisk -rx 'core show channels concise' |grep $CHANNEL_NAME)" ]
	then
		echo "$CHANNEL_NAME is $CHANNEL_TIME long"
	fi
else
	echo "0"
fi

