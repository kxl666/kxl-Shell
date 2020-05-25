#!/bin/bash
echo  -en "\e[1;32m  【请输入ping的名称】:  \e[0m"
read  a
#ip=$a
echo  -en "\e[1;35m  【请输入ping的次数】:  \e[0m"
read o
for i in ` seq $o `
do 
   #   ping -c 1 $a
   # if [ "$?" -eq 0 ]
   if ! ping -c 1 $a #另外一种方式与 -eq 0 相反 
     then 
       echo -e "\n" "\e[1;31m 【 $a is down ..】  \e[0m"
      else
       echo -e "\n"  "\e[1;31m 【 $a is up ..】  \e[0m"
    fi
done
wait
       echo -e "\n" "\e[1;31m 【欢迎下次来ping】 \e[0m"

