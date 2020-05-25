#!/bin/bash
#这个是关于return
function hello()
{
#echo "你好 $[$1+$2]"
y=$[$1 + $2]
return $y
}
read -p "请输入第一个数 :" X
read -p "请输入第二个数 :" Y
hello $X $Y
echo $?
