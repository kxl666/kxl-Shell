#!/bin/bash
sort --random-sort /实验/名字.txt |awk 'NR==1{print $0}'
