#!/usr/bin/expect
set ip 192.168.160.135
#set ip [lindex $argv 0]     #读取输入$1
set user kqf
#set user [lindex $argv 1]   #读取输入$2
set passwd `123456kqf
#set timeout 5

spawn ssh $user@$ip
expect {
	"yes/no" { send "yes\r";exp_continue }
	"passwd:" { send "$passwd\r";exp_continue }
}
#interact   #停在那
expect "#"
send "touch abc\r"
send "pwd\r"
expect eof  #退出
