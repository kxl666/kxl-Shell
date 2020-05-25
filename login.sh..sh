#!/bin/bash
y=` w -i |grep 'pts'|grep 'root' | awk '{print $4}'| awk 'BEGIN{FS=":"}{print $1}'`
x=`date | awk '{print $5}' | awk -F":" '{print $1}'`
if [ $y -eq $x ]
   then
    echo "欢迎飞哥登录" | mail -s '大佬柯全飞'  2244951869@qq.com
fi
