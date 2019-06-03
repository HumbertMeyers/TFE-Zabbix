#!/bin/bash
#Credits : https://share.zabbix.com/atc/pbx/asterisk-template
#Modifié par Humbert.

NOW=$(date '+%Y-%m-%d %H:%M')
DATE=$(date '+%Y-%m-%d %H:%M' -d  "1 hour ago")


#PASS=$(awk -F'[]]|[[]' '$0 ~ /^\[/ && $2 >= "$DATE" { p=1 } $0 ~ /^\[/ && $2 >= "$NOW" { p=0 } p { print $0 }' /var/log/asterisk/full | grep "wrong password") 
#PASS=$(awk -v DT="$DATE" '($1 " " $2) >= DT'   /var/log/asterisk/full | grep "Wrong password")


# ERRORCOUNT=$(awk -vDate="`date -d'now -1 hour' +'%Y-%m-%d %H:%M'`" '
#    BEGIN{ 
#        for(i=0; i<12; i++) 
#            MON[substr("JanFebMarAprMayJunJulAugSepOctNovDec", i*3+1, 3)] = sprintf("%02d", i+1); 
#    } 
#    toDate() > Date 
#    function toDate() { 
#        time = $5; gsub(/:/, "", time); 
#        return $4 MON[$3] $2 time ; 
#    }' /var/log/asterisk/full | grep "rong password" | wc -l ) 

#LAST=$(sudo tail -1 /var/log/asterisk/worngPassLastLOG)
#DIFF="$(($ERRORCOUNT - $LAST))"

# ERRORCOUNT=$(awk -v ldate="$( date +'%d %H-%M-%S' -d'1 hour ago' )" '$2 " " $3 >= ldate' /var/log/asterisk/full | grep "Wrong password" | grep -E '[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}' | wc -l )

ERRORCOUNT=$(cat /var/log/asterisk/full | grep 'rong password' | grep -E '[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}' | sed 's/\[//' | sed 's/]//' | awk -v date=$(date -d "1 hour ago" +"%T") '$2 >= date { print $0 }' | wc -l )


if [ "$ERRORCOUNT" \< 0 ];
   then 
	echo "0"
    else 
	echo $ERRORCOUNT 
fi

