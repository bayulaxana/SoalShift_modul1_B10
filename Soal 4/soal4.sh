#!/bin/bash

convert() {
    printf "\\$(printf "%03o" "$1")"
}

hour=`date +%H`
minute=`date +%M`
date=`date +%d`
month=`date +%m`
year=`date +%Y`

fname="$hour:$minute $date-$month-$year"
log=`cat /var/log/syslog`

lwer=$(($hour + 97))
lwer=$(($lwer % 122))
if [ $lwer == 0 ]
then
    lwer=122
fi

firstChar=`convert $lwer`
lastChar=`convert $(($lwer-1))`

if [ $lwer == 97 ]
then
    var=`printf '%s' "$log"`
else
    var=`printf '%s' "$log" | tr a-zA-Z $firstChar-za-$lastChar${firstChar^^}-ZA-${lastChar^^}`
fi

printf '%s\n' "$var" > "$fname".txt