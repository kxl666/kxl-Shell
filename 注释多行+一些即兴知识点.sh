ls 
<<EOF
echo "line 1"
echo "line 2"
echo "line 3"
EOF

# vim .bash_profile
# export PATH=$PATH:/usr/local/python37/bin
# 源码安装 定义路径 
# source .bash_profile

# 修改PSI
export PS1="\[\033]2;\h:\u \w\007\033[32;1m\]\u@$ip\h \033[35;1m\t\033[0m \[\033[34;1m\]\w\[\033[0m\] \[\e[31;1m\] # \[\e
[0m\]"
