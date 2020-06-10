#!/bin/bash

#判断密钥是否存在
if [ ! -e ~/.ssh/id_rsa ]
then
ssh-keygen -t rsa -P "" -f ~/.ssh/id_rsa && echo "新密钥创建完成"
else
 echo "密钥已经存在"
fi

#输入新用户信息
read -e -p "请输入用户名：" x
read -e -p "请输入密码:" y
#推送名单
cat >111.txt <<EOF
192.168.160.134@\`123456kqf
192.168.160.135@\`123456kqf
192.168.160.137@\`123456kqf
EOF
#判断是否第一次推送
while read a1 in
do 
ip=` echo $a1 | awk -F@ '{print $1 }' `
pass=` echo $a1 | awk -F@ '{print $2 }' `
if [ ! -e ~/.ssh/k* ] || ! grep "$ip" ~/.ssh/k* &>/dev/null
then
expect <<EOF
spawn ssh-copy-id root@$ip
expect "(yes/no)?"
send "yes\r"
expect "password:"
send "$pass\r"
expect eof
EOF
fi

#判断是否推送过并且更新过密钥
if [  -e /root/.ssh/k* ] && grep "$ip" ~/.ssh/k* &>/dev/null 
then
expect <<EOF
spawn ssh-copy-id root@$ip
expect "password:"
send "$pass\r"
expect eof
EOF
echo -en "\e[1;31m  root:$ip已经推送成功. \e[0m" 
wait
echo
fi

#连接root主机进行新用户与环境配置
ssh root@$ip <<EOF
id $x &>/dev/null || useradd -p $(openssl passwd $y ) $x && echo -en "\e[1;32m  $x is create \e[0m" 
which expect &>/dev/null || yum -y install expect 
EOF

#控制端对其他主机新用户进行密钥推送
expect <<EOF
spawn ssh-copy-id  $x@$ip
expect "passwd:"
send "$y\r"
expect eof
EOF

done <111.txt
#最后进行关键漫游设置
ip2=$( cat 111.txt | awk -F@ '{print $1}' )
while read ip3 in
do
ip4=$( echo $ip3 | awk -F@ '{print $1}' )
ssh $x@$ip4 <<EOP
ssh-keygen -t rsa -P "" -f ~/.ssh/id_rsa && echo "新密钥创建完成"
for i in ` echo $ip2 `
do
expect <<EOF
spawn ssh-copy-id $x@\$i
expect "(yes/no)?"
send "yes\r"
expect "password:"
send "$y\r"
expect eof
EOF
done
EOP

done <111.txt
wait
rm -rf 111.txt
