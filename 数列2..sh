#!/bin/bash
while true
do
unset hello
declare -A hello
        type=`ss -an |grep :0 |awk '{print $2}'`
        for i in $type
        do
              let hello[$i]++
        done

        for j in ${!hello[@]}
        do
              echo "$j: ${hello[$j]}"
        done
        sleep1 ; clear
done
