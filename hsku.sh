#!/bin/bash

hello1()
{
expect <<EOF
spawn ssh-keygen -t rsa -P "" -f /root/.ssh/id_rsa
expect "(y/n)?"
send "y\r"
expect eof
EOF
} 


hello2()
{
read -e -p "请输入ip(主):" m
#判断ip格式是否正确
while :
do    
a1=` echo "$m" | awk -F. '{print $1}' `
b1=` echo "$m" | awk -F. '{print $2}' `
c1=` echo "$m" | awk -F. '{print $3}' `
e1=` echo "$m" | awk -F. '{print $4}' `
d1=0
for i in $a1 $b1 $c1 $e1
do
if [[ "$i" =~ (^[0-9]$|^[1-9][0-9]$|^1[0-9][0-9]$|^2[0-5][0-5]$) ]]          
then
 let d1++
else
 echo $i:no

fi
done

if [ $d1 = 4 ]
then
break
else 
echo "ip格式错误!!!"
read -e -p "请输入ip(主):" m

fi

wait 
unset d1
done

read -e -p "请输入ip(从):" n
while :
do
a2=` echo "$n" | awk -F. '{print $1}' `
b2=` echo "$n" | awk -F. '{print $2}' `
c2=` echo "$n" | awk -F. '{print $3}' `
e2=` echo "$n" | awk -F. '{print $4}' `
d2=0
for y in $a2 $b2 $c2 $e2
do
if [[ "$y" =~ (^[0-9]$|^[1-9][0-9]$|^1[0-9][0-9]$|^2[0-5][0-5]$) ]]
then
 let d2++
else
 echo $i:no

fi
done

if [ $d2 = 4 ]
then
exit
else
echo "ip格式错误!!!"
read -e -p "请输入ip(从):" n
fi

wait
unset d2
done
}
