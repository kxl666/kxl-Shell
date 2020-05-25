#!/bin/bash
num=(1 2 3)
hello()
{
#     local a=11
      local i
      local hey=()
      for i in $*
      do
         hey[j++]=$[$i*3] #赋值方式：一次赋一个值
      done
       echo "${hey[*]}"
}
hello ${num[*]}
#echo "a:$a" #显示不出来因为他是内部变量




