#!/bin/bash
x=`w -i |grep 'pts/0' |grep root| awk '{print $4}'`
z=`w -i |grep 'pts/1' |grep root| awk '{print $4}'`
h=`w -i |grep 'pts/2' |grep root| awk '{print $4}'`
j=`w -i |grep 'pts/3' |grep root| awk '{print $4}'`
y=`date | awk '{print $5}' | cut -d ":" -f 1,2`
g=`w -i |grep 'pts/4' |grep root| awk '{print $4}'`
p=`w -i |grep 'pts/5' |grep root| awk '{print $4}'`
if [ $y = $x ] || [ $y = $z ] || [ $y = $h ] || [ $y = $j ] || [ $y = $g ] || [ $y = $p ]
   then
    echo "欢迎飞哥登录" | mail -s '大佬柯全飞'  2244951869@qq.com
fi
