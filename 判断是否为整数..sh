#!/bin/bash
read -e -p "请输入一个整数:" x

if [[   "$x" =~  ^-?[0-9]+$ && ! "$x" =~ ^(-0|0[0-9]+) ]] 
 then 
  echo "这是整数"
 else
  echo "这不是整数"
  bash $0
fi


# declare -i var=$x &>/dev/null
# if declare -p var | grep 'var="'$x'"'  &>/dev/null
#  then 
#   echo "这是个整数"
#  else
#   echo "这不是个整数"
#   bash $0
# fi
