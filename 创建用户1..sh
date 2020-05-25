#!/bin/bash
read -p  "请输入用户数量" -t 30 num

while true
do
      if [[ !  "$num" =~  ^[0-9]+$ ||  "$num" =~ ^0+$  ]] 
       then
        echo "【数量是数字，并且不能输入0】" 
        read  -p  "请重新输入数量 ：" num
        else
       break 
      fi
done
      
while :
do
      read -p  "请输入用户密码：" -t 30 pass
      if [ -z "$pass" ]
       then
        echo "【密码不能为空】"
       read -p  "请重新输入用户密码：" -t 30 pass
        else
       break
      fi
done         
     
while :
do
      read -p "请输入用户名：" name
      if [ -z "$name" ] 
       then
        echo "【用户名不能为空】"
       read -p "请重新输入用户名" name
        else
       






break
      fi
done

for i in `seq $num`
do
        user=$name$i
        
        id $user &>/dev/null
       if [ $? -eq 0 ]
       then 
        echo "用户$user已经存在"
       exit
       else
        useradd $user
        echo "$pass" |passwd --stdin $user &>/dev/null
        if [ $? -eq 0 ]
           then
        echo "$user 已经创建"
        fi
      fi
done
