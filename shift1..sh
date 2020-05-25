#!/bin/bash
while [ $# -ne 0 ]
do
  let sum+=$1  
  shift 1   
done
echo "sum: $sum"
