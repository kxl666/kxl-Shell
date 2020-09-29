#!/bin/bash

# 第一种会出现zabbixtimeout情况
awk '{print $4}' /var/log/httpd/access_log | awk -v time=`sed -rn 's#(.*\, )([0-9]{1,2})(.*)([A-Z][a-z]{2})(.*)([0-9]{4})(.*)([0-9]{2}\:[0-9]{2}\:[0-9]{2})(.*)#\2/\4/\6:\8#gp' < <( date -d "1 min ago" -R )` -F"\\\[" '{if($2>time){print $2}}' | awk -v mon=`date -d "1 min ago" -R | awk '{print $3}'` -F"/" '$2==mon{print }' >test.txt

rm -rf /tmp/ip.txt
for i in `cat test.txt`
do
grep "$i" /var/log/httpd/a* | egrep -o "^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" >> /tmp/ip.txt
done 
wait
cat /tmp/ip.txt | wc -l  

# 第二种解决timeout问题
#/bin/bash
while true
do

miao=`date -Rd "1 second ago"|awk '{print $2"/"$3"/"$4":"$5}'`
grep "$miao" /var/log/httpd/access_log|wc -l >>/tmp/fangwen.txt

done

# 在zabbix配置文件中 tail -n 60 /tmp/fangwen.txt | awk '{a+=$1}END{print a}'