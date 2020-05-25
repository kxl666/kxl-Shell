#!/bin/bash
ping()
{
  ping -c1 -W1 $ip &>/dev/null
  if [ $? -eq 0 ]
  then
   echo "$ip is ok" 
   continue
 fi
}
 
while read $ip
do 
 ping
 ping
 ping
 echo "$ip is failure!"
done </实验/ip.txt
