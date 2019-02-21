#!/bin/bash

makePassword() {
    newPass=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)
}

fname=""
i=1
while [ true ]
do
    check=`ls "password"$i".txt" 2> /dev/null`
    if [ ${#check} == 0 ]
    then
        fname="password"$i".txt"
        break
    fi
    i=`expr $i + 1`
done
makePassword
passCheck=`grep -w $newPass password*.txt 2> /dev/null`
while [ ${#passCheck} != 0 ]
do
    makePassword
    passCheck=`grep -w $newPass password*.txt 2> /dev/null`
done
echo $newPass > $fname
