#!/usr/bin/bash
y=$[ $RANDOM %100]
until [ "$x" -eq "$y" ] &>/dev/null
do
echo -en "\e[1;31m  【请猜数字】:  \e[0m"
read x

  if [ "$x" -lt "$y" ]
   then    
    echo "数小了"

  elif [ "$x" -gt  "$y" ]
   then 
    echo "数大了"
  
  else
    echo "恭喜答对了!!!"
    exit
  fi
done


