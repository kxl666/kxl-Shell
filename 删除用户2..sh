#!/bin/bash
cat /实验/用户密码.txt | while read username; do
       name=$(echo $username | awk '{print $1}')
       if id $name &>/dev/null
        then
         {
         user=$(su -l $name -c "echo \$HOME")
         mkdir -p /实验/曾经删除用户的信息
         mv -f $user/* /实验/曾经删除用户的信息/$name
         mv -f $user/.* /实验/曾经删除用户的信息/$name
         userdel -frZ $name
         }&>/dev/null
         echo "$name用户 删除成功"
        else
         echo "$name用户 不存在"
       fi
      done
