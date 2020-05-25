#!/bin/bash
while read ip
do
  fail=0
  for i in {1..3}
  do
   if ping -c1 -W1 $ip &>/dev/null
    then
     echo "$ip ping is ok"
     break
    else
     echo "$ip ping is no [$i]"
     let fail++
   fi
  done
  if [ $fail -eq 3 ]
   then
    echo "$ip is really down!"
  fi
done </实验/ip.txt

