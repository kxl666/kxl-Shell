#!/bin/bash

while read i
do
 name=`echo $i | awk '{print $1}'`
 pass=`echo $i | awk '{print $2}'`
 if id $name &>/dev/null
  then
   echo "用户已存在"
  else
   useradd -p $(openssl passwd '$pass') $name 
   echo "用户$name已经创建成功"
 fi
done </实验/用户密码.txt
