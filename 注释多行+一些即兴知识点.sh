#1.shell多行注释 
<<EOF
echo "line 1"
echo "line 2"
echo "line 3"
EOF

#2.1.源码安装定义路径
# vim .bash_profile
# export PATH=$PATH:/usr/local/python37/bin
# 源码安装 定义路径 
# source .bash_profile

#2.2.源码安装定义路径
ln -s /usr/python3/bin/python3 /usr/bin/python3

#3.1.修改PSI .bashrc
export PS1="\[\033]2;\h:\u \w\007\033[32;1m\]\u@$ip\h \033[35;1m\t\033[0m \[\033[34;1m\]\w\[\033[0m\] \[\e[31;1m\] # \[\e
[0m\]"
#3.2.修改全局PSI /etc/bashrc
[ "$PS1" = "\\s-\\v\\\$ " ] && PS1='\[\e[34m\][\u@\h\t \W]#\[\e[m\] '

#4.编译连接执行C源程序文件
#gcc hello.c -o hello
#./hello

#5.修改系统语言
export LANG=en_US.UTF-8
