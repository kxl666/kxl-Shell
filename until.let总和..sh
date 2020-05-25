#!/bin/bash
i=1
until [ $i -gt 100 ]
do
        let sum=$sum+$i
        let i++
done
echo "sum is $sum"
