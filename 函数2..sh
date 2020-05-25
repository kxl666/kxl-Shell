#!/bin/bash
hello()
{
yeah=1
for((i=1;i<=$1;i++))
do
    yeah=$[$1*$yeah]  
done
echo "$1 的阶乘是: $yeah"
}
hello $1


