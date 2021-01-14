#!/bin/bash
if ! [  -e hsku.sh ];then wget https://raw.githubusercontent.com/kxl666/kxl666/master/hsku.sh && echo -en "\e[1;35m  下载函数库成功 \e[0m";fi
echo
sleep 2
while [ ! -e hsku.sh ]
do
echo -en "\e[1;34m  下载函数库成功 \e[0m"
echo 
wget https://raw.githubusercontent.com/kxl666/kxl666/master/hsku.sh
done

which expect &>/dev/null || yum -y install expect
mkdir /shiyan &>/dev/null
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
                 . hsku.sh
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
192.168.160.10
192.168.160.20
192.168.160.30
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
spawn ssh-copy-id $user@$ip
expect "(yes/no)?"
send "yes\r"
expect "password:"
send "\`123456kqf\r"
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
{
a=$(cat /shiyan/判断密钥更改时间)
b=$(stat ~/.ssh/id_rsa | awk -F "[： .]" '/更改/{print $2,$3}')
h=` cat /shiyan/判断密钥更改时间3 `
}&>//dev/null
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
read -e -i "y" -p "是否继续[y|n]" ulk
if [ $ulk = n ] ;then exit ;else echo "将继续!"  ;fi
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
name=kxl
baseurl=file:///kqf
enabled=1
gpgcheck=0
DOF
##清除原有缓存，建议新的缓存
        yum clean all &>/dev/null
        yum makecache   
cd /etc/yum.repos.d/
wget http://mirrors.163.com/.help/CentOS6-Base-163.repo
 yum makecache  && echo -en "\e[1;31m  yum源已经创建成功 \e[0m" || echo -en "\e[1;31m  yum源已经创建成功 \e[0m" 
 cd -
EOF
done < 1.txt
fi
fi

read -e -i "n" -p "是否进行DNS主从配置[y|n]：" fof
if [ "$fof" = "y" ]
then
#开始对DNS服务端配置
echo "与从主机ip是之前公钥推送过的保持一致"
#判断ip格式是否正确
. hsku..sh
hello2
k=`echo $m`
l=`echo $n`

read -e -i "kxl.com" -p "请输入域名：" rrr
#判断域名格式是否正确
if [[ ! "$rrr" =~ ^[a-z]+\.[a-z]{1,}$ ]]
then
echo $0
else
#对主
ssh root@$k <<eof
yum install -y bind bind-utils
systemctl enable named
systemctl start named
#关闭防火墙
systemctl stop firwalld 
#永久关闭SELINUX
if ! [[ $(getenforce) == "Disabled" ]]
then
sed -r -i '/^[ \t]*SELINUX=/c\SELINUX=disabled' /etc/selinux/config 
. /etc/selinux/config  
fi
#在主配置文件/etc/named.config中
sed -i -r 's/(^\s*listen-on\s+port\s+53\s+\{).*(\}\s*;$)/\1any;\2/' /etc/named.conf
sed -i -r 's/(^\s*listen-on-v6\s+port\s+53\s+\{).*(\}\s*;$)/\1any;\2/' /etc/named.conf
sed -i -r 's/(^\s*allow-query\s+\{).*(\}\s*;$)/\1any;\2/' /etc/named.conf
systemctl restart named
#配置：<主从复制>中的<Master主>
cat > /etc/named.test.com.conf <<EOF
zone "$rrr" IN {
     type master;
     file "zone.$rrr";  
     notify yes;
     allow-update { any; };
};
EOF
echo '\$TTL 1D
\$ORIGIN $rrr.
@ IN SOA dns01.$rrr. 123456789.qq.com. (
                         0
                         1D
                         1H
                         1W
                         3H )
@     NS    dns01.$rrr.
@     NS    dns02.$rrr.
dns01 A     $k
dns02 A     $l' >/var/named/zone.$rrr
eof

if ! grep -E "^\s*include\s+\"/etc/named\.test\.com\.conf\";" /etc/named.conf &> /dev/null; then
   echo 'include "/etc/named.test.com.conf";' >> /etc/named.conf
fi
systemctl restart named
## 配置：<named进程运行用户>具备<动态注册和更新>的权限
chown :named /var/named
chmod g=rwx /var/named
chown named:named /var/named/zone.test.com
chmod 660 /var/named/zone.$rrr
#把网卡配置文件的DNS指向自己
sed -i '/^DNS/d' /etc/sysconfig/network-scripts/*ens33
echo DNS1=$k >>/etc/sysconfig/network-scripts/*ens33
sed -i '/^GATEWAY/d' /etc/sysconfig/network-scripts/*ens33
systemctl restart network
eof

#对从
ssh root@$l <<eof
yum install -y bind bind-utils
systemctl enable named
systemctl start named
systemctl stop firwalld 
if ! [[ $(getenforce) == "Disabled" ]]
then
sed -r -i '/^[ \t]*SELINUX=/c\SELINUX=disabled' /etc/selinux/config 
. /etc/selinux/config  
fi

cat > /etc/named.test.com.conf <<EOF
zone "$rrr" IN {
     type slave;
     file "slaves/zone.$rrr";
     masters { $k; };
     allow-update-forwarding { any; };
     // allow-update { none; };
};
EOF
if ! grep -E "^\s*include\s+\"/etc/named\.test\.com\.conf\";" /etc/named.conf &> /dev/null; then
   echo 'include "/etc/named.test.com.conf";' >> /etc/named.conf
fi
systemctl restart named
sed -i '/^DNS/d' /etc/sysconfig/network-scripts/*ens33
sed -i '/^GATEWAY/d' /etc/sysconfig/network-scripts/*ens33
echo GATEWAY=$k >>/etc/sysconfig/network-scripts/*ens33

eof
fi
else
read -e -i "y" -p "是否继续[y|n]" ulkg
if [ $ulkg = n ] ;then exit ;else echo "将继续!"  ;fi

fi

wait
echo

read -e -i "no" -p "是否进行消息队列配置[yes|no]" ops
if  [ $ops = yes ]
then

while read gh in 
do
ssh $gh <<EOF
#1. YUM安装：rabbitmq-server 消息队列服务
yum -y install epel-release.noarch
yum install -y rabbitmq-server
systemctl enable rabbitmq-server
systemctl start rabbitmq-server
rabbitmq-plugins enable rabbitmq_management
systemctl restart rabbitmq-server
systemctl stop firewalld
setenforce 0
cat > /etc/hosts <<EOFf
192.168.160.10 server01
192.168.160.20 server02
192.168.160.30 server03
EOFf

EOF
done < 1.txt
if [ $? = 0 ];then echo -en "\e[1;34m "1. YUM安装：rabbitmq-server 消息队列服务已成功！"  \e[0m" ;else echo "" ; fi
echo

#2. 同步数据

while read liew in
do
if ! [ $liew = `ip a | grep ens33 | egrep -o "[0-9]{3}\.[0-9]{3}\.[0-9]{1,3}\.[0-9]{1,3}" | head -1` ]
then
ssh $liew "systemctl stop rabbitmq-server"
scp server01:/var/lib/rabbitmq/.erlang.cookie $liew:/var/lib/rabbitmq/.erlang.cookie
ssh $liew "systemctl start rabbitmq-server"

ssh $liew "rabbitmqctl stop_app"
ssh $liew "rabbitmqctl join_cluster --ram rabbit@server01"
ssh $liew "rabbitmqctl start_app"
fi
done < <(awk '$1~/192/{print $1}' /etc/hosts | sort | uniq )

fi
if  [ $ops = yes ] ; then echo -en "\e[1;34m "★ 部署：rabbitMQ 消息队列服务集群 OK" \e[0m" ;fi
echo



