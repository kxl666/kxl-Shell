#!/bin/bash
num=(1 4 3 4)
hello()         #hello为任意哦
{
#yeah=1
local yeah=1    #申明内部变量   
for i in "$@"   #读取输入的元数值
do
    yeah=$[$yeah*$i]
done
    echo "$yeah"
}
hello ${num[*]} #数组所有元数值
   
