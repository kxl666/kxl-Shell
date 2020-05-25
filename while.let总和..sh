#!/bin/bash
i=1
while [ $i -le 100 ]
do
      let sum=$sum+$i
      let i++
done	
echo "sum is $sum"
