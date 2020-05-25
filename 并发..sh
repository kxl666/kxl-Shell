#!/bin/bash
#解决ping的并发问题
read -p "请输入并发数 :" o
fifofile=/实验/$$.fifo

mkfifo $fifofile
exec 6<> $fifofile
rm $fifofile

for i in ` seq $o `  
do
      echo >&6
done

for i in ` seq 1 100 `
do
    read -u 6
    {
    ip=192.168.160.$i
    ping -c1 -W1 $ip &>/dev/null
    if [ $? -eq 0 ]
     then
      echo "$ip is up"
     else
      echo "$ip is down"
    fi
    echo >&6
    }&
done
wait
exec 6>&-
echo "结束"
