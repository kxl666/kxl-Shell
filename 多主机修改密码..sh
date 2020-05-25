#!/bin/bash
read -e -p "请输入需要修改的密码：" x

for ip in ` cat /shiyan/ip.txt `
do
 {
 if ping $ip &>/dev/null
  then 
   ssh $ip "echo $x |passwd --stdin root"
   if [ $? -eq 0 ]
    then
     echo "$ip" >>/shiyan/ping/ok.`date +%F`.txt
    else
     echo "$ip" >>/shiyan/ping/fail.`date +%F`.txt
   fi
  else
   echo "$ip" >>/shiyan/ping/fail.`date +%F`.txt
 fi
 }&
done
wait 
echo "完成"
