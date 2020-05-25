#!/bin/bash
if [ $# -ne 3 ]
  then 
   echo "用法: `basename $0` num1 num2 num3"
   exit
fi

hello()
{
echo "$[$1 * $2 * $3]"
}
result=`hello $1 $2 $3`
echo "结果: $result"
