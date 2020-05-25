
###################################
##!/bin/bash 
#for X in ` seq 1 9 `
#do
#for ((Y=1;Y<=X;Y++))
#do
#echo -n -e "$X*$Y="$((X*Y))"\t"
#done
#echo -e "\n"
#done
##################################
!/bin/bash
i=1
while [ $i -le 9 ]
do
   y=1
   while [ $y -le $i ]
   do
    echo -e -n  "$y*$i=" $[i*y]"\t"
    let y++
   done
   echo -e "\n"
    let i++
done
  

   
    




















