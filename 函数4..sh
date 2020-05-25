#!/bin/bash
hello()
{
read -p "请输入数字:" num
echo $[2*$num]
}
result=`hello` #此时在子shell中执行
echo "结果是: $result"


