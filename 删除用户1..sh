#!/bin/bash
awk -F: 'NR>42{print $1}'  /etc/passwd > /实验/删除用户名.txt

while read i
do
  if id $i &>/dev/null
   then
    userdel -rf $i &>/dev/null
    echo "用户$i已经删除"
  fi
done < /实验/删除用户名.txt

