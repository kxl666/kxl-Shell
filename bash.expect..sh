#!/bin/bash
pas='`123456kqf'
#pas=$1
#/usr/bin/expect <<-EOF
expect <<EOF
#set time 10
#set timeout 10
spawn ssh root@192.168.160.134 ls #ssh后面+命令,后面自动应答的命令就失效了,而且只能跟一个命令，但是这的命令比自动应答快。
expect {                          #除非直接ssh后面可以+很多命令,前提两者已经公钥推送了。         
"password" { send "$pas\r" ;exp_continue }
}

#spawn /usr/bin/su -             #suh后面+命令，无效，也许只有ssh支持后面+命令。
#expect {
#"密" { send "$pas\r" ;exp_continue }
#}


#expect {
#"密" { send "$pas\r" }
#}

#expect "密"
#send "$pas\r"

#expect {
#     "#" { send "ls\r" }
#}

#expect "#" { send "pwd\n" }
#expect eof                      #对于#!/bin/bash的自动应答，不需要expect eof 作为结尾。
EOF                              #但对于#!/usr/bash/expect来说，没它会导致不自动应答命令，密码登录完，就退出了。
wait 
echo 
