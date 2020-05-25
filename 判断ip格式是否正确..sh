#!/bin/bash
a=` echo "$1" | awk -F. '{print $1}' `
b=` echo "$1" | awk -F. '{print $2}' `
c=` echo "$1" | awk -F. '{print $3}' `
e=` echo "$1" | awk -F. '{print $4}' `
d=0
for i in $a $b $c $e
do
if [[ "$i" =~ (^[0-9]$|^[1-9][0-9]$|^1[0-9][0-9]$|^2[0-5][0-5]$) ]]          
then
 let d++
else
 echo $i:no
fi
done

if [ $d = 4 ]
then
echo good
fi

wait 
unset d
