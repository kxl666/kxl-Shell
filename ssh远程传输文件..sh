#!/usr/bin/expect
set ip [lindex $argv 0]
set user [lindex $argv 1]
set password `123456kqf
set timeout 5
spawn scp -r /shiyan/ip.txt $user@$ip:/tmp
expect {
	"yes/no" { send "yes\r"; exp_ continue }
	"password:" { send "$password\r" };
       }
expect eof
