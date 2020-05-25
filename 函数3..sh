#!/bin/bash
hello()
{
read -p "enter num :" num
return $[2*$num]
}
hello 
echo "结果是：$?"
