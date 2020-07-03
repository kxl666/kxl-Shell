#!/bin/bash

#首先判断有无密钥
if [ ! -e ~/.ssh/id_rsa ]
then
ssh-keygen -t rsa -P "" -f ~/.ssh/id_rsa && echo "新密钥创建完成"
else
 echo "密钥已经存在"
fi
#再判断需要更新密钥吗？
while :
do
read -e -n 1 -p "需要更新密钥吗？[y|n]" x
        case $x in
                y)
                 . /shiyan/hsku
                 hello1 &>/dev/null
                 o=y
                 echo "密钥已更新" 
                 stat ~/.ssh/id_rsa | awk -F "[： .]" '/更改/{print $2,$3}' > /shiyan/判断密钥更改时间
                 break
                 ;;
                n)
                 o=n
                 break
                 ;;
                *)
                echo erro
                ;;
      esac
done
#然后进行公钥推送
cat >1.txt <<EOF
192.168.160.134
192.168.160.136
EOF
#-----------------
while :
do
 read -e -p "请输入需要推送的用户:" user
 if [ ${#user} = 0 ] 
  then
   echo "不能为空"
  else 
   break
 fi
done

while read ip
do
#判断是否第一次推送
if [ ! -e ~/.ssh/k* ] || ! grep "$ip" ~/.ssh/k* &>/dev/null
then
expect <<EOF
expect "(yes/no)?"
send "yes\r"
expect "password:"
send "\`123456kqf"
expect eof
EOF
fi
#判断是否推送过并且更新过密钥
if [  -e /root/.ssh/k* ] && grep "$ip" ~/.ssh/k* &>/dev/null && [ $o = y ] &>/dev/null
then
expect <<EOF
spawn ssh-copy-id $user@$ip
expect "password:"
send "\`123456kqf\r"
expect eof
EOF
echo -en "\e[1;31m  $user:$ip已经推送成功. \e[0m" 
wait
echo
fi

#判断root是否推送过并且没有更新密钥
a=$(cat /shiyan/判断密钥更改时间)
b=$(stat ~/.ssh/id_rsa | awk -F "[： .]" '/更改/{print $2,$3}')
h=` cat /shiyan/判断密钥更改时间3 `
if [  -e /root/.ssh/k* ] && grep "$ip" ~/.ssh/k* &>/dev/null && [ $o = n ] &>/dev/null  && [ ! "$a" = "$b" ]  && [ $user = root ]
then
expect <<EOF
spawn ssh-copy-id $user@$ip
expect "password:"
send "\`123456kqf\r"
expect eof
EOF
echo -en "\e[1;31m  $user:$ip已经推送成功.. \e[0m"
fi

#if [  -e /root/.ssh/k* ] && grep "$ip" ~/.ssh/k* &>/dev/null && [ $o = n ] &>/dev/null  && [ ! "$a" = "$b" ] && [  "$b" =  "$g"  ] && [ $user = root ]
#then
#echo -en "\e[1;31m  $user:$ip已经推送过了.. \e[0m"
#fi

if [  -e /root/.ssh/k* ] && grep "$ip" ~/.ssh/k* &>/dev/null && [ $o = n ] &>/dev/null  && [ ! "$a" = "$b" ] && [ ! "$b" =  "$h"  ] && [  $user != root ]
then
stat ~/.ssh/id_rsa | awk -F "[： .]" '/更改/{print $2,$3}' > /shiyan/判断密钥更改时间3
expect <<EOF
spawn ssh-copy-id $user@$ip
expect "password:"
send "\`123456kqf\r"
expect eof
EOF
echo -en "\e[1;31m  $user:$ip已经推送成功.... \e[0m"
fi

if [  -e /root/.ssh/k* ] && grep "$ip" ~/.ssh/k* &>/dev/null && [ $o = n ] &>/dev/null  && [ ! "$a" = "$b" ] && [  "$b" =  "$h"  ] && [  $user != root ]
then
expect <<EOF
spawn ssh-copy-id $user@$ip
expect "password:"
send "\`123456kqf\r"
expect eof
EOF
echo -en "\e[1;31m  $user:$ip已经推送成功.... \e[0m"
fi

if [  -e /root/.ssh/k* ] && grep "$ip" ~/.ssh/k* &>/dev/null && [ $o = n ] &>/dev/null  && [  "$a" = "$b" ] && [ $user = root ]
then
echo -en "\e[1;31m  $user:$ip已经推送过了... \e[0m"
fi

if [  -e /root/.ssh/k* ] && grep "$ip" ~/.ssh/k* &>/dev/null && [ $o = n ] &>/dev/null  && [  "$a" = "$b" ] && [ ! $user = root ]
then
expect <<EOF
spawn ssh-copy-id $user@$ip
expect "password:"
send "\`123456kqf\r"
expect eof
EOF
echo -en "\e[1;31m  $user:$ip已经推送成功... \e[0m"
fi

wait
echo


done <1.txt
#最后开始进行远程yum源配置
if [ $user != root ]
then 
 exit
else

echo -en "\e[1;34m  是否需要远程yum源配置[y|n]： \e[0m" 
read  qw
if [ ! "$qw" = "y" ]
then
 exit
else

while read ip
do
ssh $user@$ip <<EOF
        ##创建挂载点将sr0挂载上去，并加入开机启动
        mkdir /kqf &>/dev/null
        sed -i '/mount -t iso9660 \/dev\/sr0 \/kqf/d' /etc/rc.d/rc.local &>/dev/null
        mount -t iso9660 /dev/sr0 /kqf &>/dev/null
        echo 'mount -t iso9660 /dev/sr0 /kqf' >>/etc/rc.d/rc.local
        chmod a+x /etc/rc.d/rc.local
        ##配置本地yum
        rm -rf /etc/yum.repos.d/bak
        mkdir /etc/yum.repos.d/bak
        mv /etc/yum.repos.d/* /etc/yum.repos.d/bak &>/dev/null
##编写本地yum文件
cat > /etc/yum.repos.d/kxl.repo <<DOF
[kxl]
name=xqq
baseurl=file:///kqf
enabled=1
gpgcheck=0
DOF
##清除原有缓存，建议新的缓存
        yum clean all &>/dev/null
        yum makecache   
cd /etc/yum.repos.d/
 mv CentOS-Base.repo CentOS-Base.repo.bk 
wget http://mirrors.163.com/.help/CentOS6-Base-163.repo
 yum makecache  && echo -en "\e[1;31m  yum源已经创建成功 \e[0m" || echo -en "\e[1;31m  yum源已经创建成功 \e[0m" 
 cd -
EOF
done < 1.txt
fi
fi
wait
rm -rf 1.txt
echo
