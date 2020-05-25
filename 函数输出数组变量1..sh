#!/bin/bash
num=(1 2 3)
num2=(2 4 5)
hello()
{
      local yeah=(`echo $*`)
      local i
      for((i=0;i<$#;i++))
      do
         hey[$i]=$(( ${yeah[$i]} + 34  ))
      done
       echo "${hey[*]}"
}
hello ${num[*]}
hello ${num2[*]}




