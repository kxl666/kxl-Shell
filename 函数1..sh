#!/bin/bash
#这个是关于return
<<EOF
X = 1
Y = 2
#1.此时定义X Y的值,如果输入传参值变量名也是X Y ,那么此时的X Y 会被忽略
#2.相反,不存在输入传参值变量 或 输入传参值变量名与此时的X Y不一样,则会生效
#3.用于调用函数库试试
EOF
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
