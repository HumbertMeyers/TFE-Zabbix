#!/bin/bash
#Credits : https://share.zabbix.com/atc/pbx/asterisk-template

UP=$( ps -A | grep -w mysqld | wc -l);
if [ "$UP" -ne 1 ];
then
        echo "0";
       
else
        echo "1";
fi
