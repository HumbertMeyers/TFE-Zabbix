#!/bin/bash
#Credits : https://share.zabbix.com/atc/pbx/asterisk-template

if [ -n "$(sudo find /tmp/ -type f -mtime -1 -name "core*")" ]
    then 
    echo 1

    else
    echo 0
    fi
