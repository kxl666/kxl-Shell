#!/bin/bash
pass=\`123456kqf
#pass=$1
#这里赋值方式与expect不同

#第一种开始方式
#expect <<EOF
#第二种开始方式
/usr/bin/expect <<EOF
spawn ssh root@192.168.160.135 ls 
#-->> 后面+命令或多条命令(";") ,但是后面只能识别自动应答的密码，指令会报错,并且有无expect eof 无所谓，因为都不能识别了。
set time 1
#这里设置与expect不一样
#_______________________________________1
#   expect {
#        "password:" { send "$pass\r" }
#    }   
#
#    expect {
#        "#" { send "ls\r" }
#    }
#_______________________________________2
expect "password:"
send "$pass\n"
#expect "#"
#send "ls\n"
#_______________________________________3
#expect "password:" { send "$pass\n" } 
#expect "#" { send "ls\n" } 
#_______________________________________4
#expect { 
#        "password:" { send "$pass\n";exp_continue } 
#        "#" { send "ls\n" }
#    } 
#___________以上是四种自动应答方式_______
#     ________expect同样适用_______
expect eof
EOF
wait
echo
