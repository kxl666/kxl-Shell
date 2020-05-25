#!/bin/bash
array=(`cat /实验/名字.txt`)
y=` seq 0 9 | shuf -n 1 `
echo ${array[$y]}  
