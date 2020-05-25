#!/bin/bash
num=(1 4 3 4)
num2=(1 3 4 4)
hello()         #hello为任意哦
{
#yeah=1
local yeah=1    #申明内部变量   
for i in "$@"   #读取输入的元数值
#for i in ${num[*]} #写死了此时用不了num2
do
    yeah=$[$yeah*$i]
done
    echo "$yeah"
}
hello ${num[*]} #数组所有元数值
hello ${num2[*]}
#hello          #写死了此时用不了num2 
