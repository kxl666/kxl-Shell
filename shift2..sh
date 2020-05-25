#!/bin/bash
while [ $# -ne 0 ]
do
      useradd $1 &>/dev/null
      echo '`123456kqf' | passwd $1 -f --stdin
      echo "$1 is created"
      shift 1
done
