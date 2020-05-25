#!/bin/bash
# 判断id_rsa密钥文件是否存在
if [ ! -f ~/.ssh/id_rsa ];then
 ssh-keygen -t rsa -P "" -f ~/.ssh/id_rsa
else
 echo "id_rsa has created ..."
fi

#分发到各个节点,这里分发到host文件中的主机中.
while read line
  do
    user=`echo $line | cut -d " " -f 2`
    ip=`echo $line | cut -d " " -f 1`
    passwd=`echo $line | cut -d " " -f 3`
    
    expect <<EOF
      set timeout 10
      spawn ssh-copy-id $user@$ip
      expect {
        "yes/no" { send "yes\n";exp_continue }
        "password" { send "$passwd\n" }
      }
     expect "password" { send "$passwd\n" }
EOF
  done </shiyan/ip2.txt

