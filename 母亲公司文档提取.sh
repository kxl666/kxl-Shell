#!/bin/bash
{
while read line
do
 while read lnie
 do
  a=` echo $lnie | awk '{print $1}' `
  b=`echo $lnie | awk '{print $3}' `
  if [ "$a" = "$line" ] && [ $b -gt 1 ]
   then 
    echo "$lnie" >>`echo $line`.txt 
  fi
  
 done< <(awk '{print $3"      "$4"       "$7}' all.txt)

done < <(awk '{print $3}' all.txt | sort | uniq )
}&

wait 

for i in *

do
if [[ "$i" =~ 村|会.txt$ ]]
 then
 sed -ri '1i 所属村居    户主姓名  原保障人口' $i
fi
done

