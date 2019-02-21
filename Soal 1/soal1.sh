#!/bin/bash
i=0

for j in nature/*.jpg
do
base64 -d $j | xxd -r > Pictures/$i.jpg
i=$(($i+1))
done
