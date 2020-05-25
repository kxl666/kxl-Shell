#!/bin/bash
read -p "请输入文件:" q
declare -A kqfs
while read line
do
      type=`echo $line |awk -F":" '{print $NF}'`
      let kqfs[$type]++
done <$q

for i in ${!kqfs[@]}
do
      echo "$i: ${kqfs[$i]}"
done

#第二种（最简单）
#cat $q | awk -F: '{print $NF}'| sort | uniq -c
##第三种 （awk 函数）
#awk -F: '{hello[$NF]++}END{for(i in hello){print i,hello[i]}}' $q
#
