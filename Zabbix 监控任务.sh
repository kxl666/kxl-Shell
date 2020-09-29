一、Zabbix httpd Web 监控（自定义模板：CentOS 7 Aapche Web Moniter）
★ 监控：<httpd 服务>（间隔 1 分钟）
★ 监控项：
PV量：<网站页面>的<点击访问量>
IP量：<网站>的<客户端IP访问量>
监控：<http服务>是否运行？ ▶ 检查：正在侦听<指定端口>
监控：<https服务>是否运行？ ▶ 检查：正在侦听<指定端口>
监控：<httpd进程>的<进程数>、<线程数>、<CPU占用率>、<内存占用率>、<内存实际占用>

二、Zabbix Linux主机 通用监控（自定义模板：CentOS 7 Server Moniter）
★ 监控：<整机>的<运行状态>
★ 监控项：
监控 top 的 %Cpu us：CPU处理<用户态进程>的<时间占比>
监控 top 的 %Cpu sy：CPU处理<内核态进程>的<时间占比>
监控 top 的 %Cpu wa：CPU等待完成<I/O输入输出操作>的<等待时间占比>
监控 top 的 %Cpu id：CPU处于<空闲状态>的<时间占比>
监控 top 的 %CPU load average：5分钟内的<CPU平均负载率> ▶ 用于衡量<CPU工作>的<饱和度>
监控：<物理内存>的<使用量 %>
监控：<交换分区>的<使用量 %>
监控：<指定 mount 挂载点>的<使用量 %>

监控：<指定 mdadm raid 5 阵列设备>的<健康状态>
监控：<指定 disk 磁盘>的<write 写入速率>
监控：<指定 disk 磁盘>的<read 读取速率>
监控：<指定 网卡>的<send 发送速率>
监控：<指定 网卡>的<receive 接收速率>
监控：<主机>网络通信的各个<TCP/IP 状态机>的<数量>




UserParameter=vg,cat /tmp/ip.txt |  wc -l
UserParameter=ip,cat /var/log/httpd/access_log | sort| awk '{print $1}' | uniq  | sed -rn '/^[0-9]/'p | wc -l
UserParameter=port,ss -tunlp  | grep ":88" | grep -o 88 &>/dev/null && echo 1 | echo 0
UserParameter=pidnum,ps -C httpd | wc -l
UserParameter=lwpnum,ps -C httpd -L | wc -l
UserParameter=cpu,ps -C httpd -o %cpu | awk 'NR>1{a+=$1}END{print a}'
UserParameter=mem,ps -C httpd -o %mem | awk 'NR>1{b+=$1}END{print b}'

UserParameter=us,timeout 1s top -b >/tmp/1.txt ;awk 'NR==3{print $2}' /tmp/1.txt
UserParameter=sy,timeout 1s top -b >/tmp/2.txt ;awk 'NR==3{print $4}' /tmp/2.txt
UserParameter=wa,timeout 1s top -b >/tmp/3.txt ;awk 'NR==3{print $10}' /tmp/3.txt
UserParameter=id, timeout 1s top -b >/tmp/4.txt ;awk 'NR==3{print $8}' /tmp/4.txt
UserParameter=average,c=`uptime  | awk '{print $8}' | grep -o "...."` ; d=`uptime  | awk '{print $9}' | grep -o "...."` ;e=`uptime  | awk '{print $10}'` ; echo "scale=4;($c+$d+$e)/3" | bc
UserParameter=memm,free -m  | awk 'NR==2{print}'| awk 'f=$3,g=$2{print $3/$2*100}'
UserParameter=swapp,free -m  | awk 'NR==3{print}'| awk 'f=$3,g=$2{print $3/$2*100}'
UserParameter=mountroot,df -Th |awk 'NR==2{print $(NF-1)}' | grep -o ".."
UserParameter=raid5,lsblk | grep md127 | wc -l
UserParameter=kB_read,iostat | grep sda  | awk '{print $3}'
UserParameter=kB_wrtn,iostat | grep sda  | awk '{print $4}'


UserParameter=tcpnum,ss -tunlp | grep tcp| wc -l
UserParameter=ipreceive,vnstat -tr 2 -i ens33 | grep rx | awk '{print $2}'
UserParameter=ipsend,vnstat -tr 2 -i ens33 | grep tx | awk '{print $2}'
UserParameter=tcpTIME_WAIT,netstat | grep -e "TIME_WAIT" | grep "tcp " | wc -l

### UserParameter=hh[*],bash /tmp/1.sh $1
### zabbix_get -s 192.168.160.135 -k hh[yello]
### vim /tmp/1.sh
#!/bin/bash

yello ()
{
echo 666
}

hello ()
{
echo 777
}
$1
