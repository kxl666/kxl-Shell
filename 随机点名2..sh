#!/bin/bash
y=$[$RANDOM % 10]
array=(`cat /实验/名字.txt`)
echo -e  "\e[1;35m ${array[$y]} \e[0m" 
