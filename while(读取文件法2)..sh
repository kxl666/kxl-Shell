#!/bin/bash
cat /home/kqf/1.txt | while read i
do
 let i+=1
 echo $i
done 
 
