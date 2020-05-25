#!/bin/bash
ip="192.168.160.135 www.baidu.com"
for i in $ip
do
  for count in {1..3}
   do
   if ping -c1 -W1 $i &>/dev/null #是不是很神奇，直接if
    then
     echo "$i ping is ok"
     break
    else
     echo "$i ping is no: $count" 
     fail[$count]=$ip
   fi
   done
   if [ ${#fail[*]} -eq 3 ]
    then
     echo "$i ping is failure!"
     unset fail[*]
   fi
done
