#!/bin/bash
#读取变量y
read -p  "请输入数字[1|2]:" y
#开始循环
while :
do
#开始if判断
if [ $y -eq 1 ] &>/dev/null
   then
    echo "wo zhne shuai"
    break
  elif [ $y -eq 2 ] &>/dev/null
   then
    echo "ta zui shaui"
    break
#判断是否为空
  elif [ $# -eq 0 ]
   then
    read -p "请重新输入数字[1|2]:" y
#判断y是否为数字
  elif [[ ! "$y" =~ ^[0-9]+$ ]]
   then
    echo "请重新输入数字[1|2]:" y 
  else
   echo "please input the true number 1or2 :" y
fi
#if判断结束
#循环结束    
done
