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

while [ true ]
do
    num=0
    lower=0
    upper=0
    exist=1
    makePassword
    passCheck=`grep -w $newPass password*.txt 2> /dev/null`
    if [ ${#passCheck} == 0 ]
    then
        exist=0
    fi

    for (( i=0; i<12; i++ )) 
    do
        x=`printf "%d\n" "'${newPass:$i:1}"`
        if [ $x -ge 97 -a $x -le 122 ]; then lower=1;
        elif [ $x -ge 65 -a $x -le 90 ]; then upper=1;
        elif [ $x -ge 48 -a $x -le 57 ]; then num=1; fi
    done
    if [ $lower == 1 -a $upper == 1 -a $num == 1 -a $exist == 0 ]; then break; fi
done
echo $newPass > $fname