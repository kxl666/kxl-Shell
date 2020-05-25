#!/bin/bash
cat > /实验/点名shuf <<EOF
张三
李四
王五
EOF
cat /实验/点名shuf | shuf -n 1
