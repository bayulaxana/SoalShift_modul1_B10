#!/bin/bash
i=0

unzip nature.zip

checkFolder=`ls Pictures 2> /dev/null`
if [ ${#checkFolder} == 0 ]
then
    mkdir Pictures
fi

for j in nature/*.jpg
do
base64 -d $j | xxd -r > Pictures/$i.jpg
i=$(($i+1))
done
