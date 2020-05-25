#!/bin/bash
###IP函数
hello1(){
        shanchu=`sed -i '/IPADDR/d' /etc/sysconfig/network-scripts/ifcfg-ens33`
        sed -i 's/ONBOOT.*/ONBOOT=yes/' /etc/sysconfig/network-scripts/ifcfg-ens33
while :
do
	echo '------------------------------'
        read -e -p "请问您是想要dhcp还是none模式呢？" zt
        case $zt in
                dhcp)
			$shanchu
                        sed -i 's/BOOTPROTO.*/BOOTPROTO=dhcp/' /etc/sysconfig/network-scripts/ifcfg-ens33
			break
                ;;  
                none)
			$shanchu
			echo '--------------------------'
                        read -e -p "请输入你想更改的静态IP：" none
                        sed -i 's/BOOTPROTO.*/BOOTPROTO=none/' /etc/sysconfig/network-scripts/ifcfg-ens33
			echo "IPADDR=$none" >> /etc/sysconfig/network-scripts/ifcfg-ens33
			break
                ;;
		*)
			echo '--------------'
			echo '请输入指定模式'			
			
        esac
done
			echo 
                     service network restart 1>/dev/null
                     ip=`ip add | grep 'inet .*brd' | awk '{print $2}' | egrep  -o '([0-9]+\.?){4}'`&& echo -e "网卡启动成功\n您的IP是$ip"


}


###关闭SElinx函数
hello2(){
	selinux=`grep '^SELINUX=.*' /etc/selinux/config`
	echo '#####################'
	if [ -a /etc/selinux/config -a "$selinux" ]
	then
		sed -i 's/^SELINUX=.*/SELINUX=disabled/' /etc/selinux/config && echo '已将SElinux功能关闭'
	else
		echo '关闭SElinux功能失败请自行进一步排查原因'
	fi
}


###本地yum配置
hello3(){
	##创建挂载点将sr0挂载上去，并加入开机启动
        mkdir /gzd &>/dev/null
	sed -i '/mount -t iso9660 \/dev\/sr0 \/gzd/d' /etc/rc.d/rc.local &>/dev/null
	mount -t iso9660 /dev/sr0 /gzd &>/dev/null
        echo 'mount -t iso9660 /dev/sr0 /gzd' >>/etc/rc.d/rc.local
        chmod a+x /etc/rc.d/rc.local
	##配置本地yum
        rm -rf /etc/yum.repos.d/bak
        mkdir /etc/yum.repos.d/bak
        mv /etc/yum.repos.d/* /etc/yum.repos.d/bak &>/dev/null
##编写本地yum文件
cat > /etc/yum.repos.d/hello.repo <<EOF
[hello]
name=xqq
baseurl=file:///gzd
enabled=1
gpgcheck=0
EOF
##清除原有缓存，建议新的缓存
        yum clean all &>/dev/null
        yum makecache  && echo '本地yum建立成功' || echo '本地yum建立失败'



}


##安装软件
hello4(){
	read -e -p "请输入您想安装的软件名：" rz
	echo '请稍后。。。。。。'
	yum install -y $rz &>/dev/null && echo '安装完成' || echo '安装失败'
}


##创建用户
hello5(){
	read -p "输入你想创建的用户名：" yonghu
                if id $yonghu &>/dev/null
                then
                        echo "$yonghu用户以存在不可创建"
                else
                        read -p "请输入密码：" mm
                        useradd -p $(openssl passwd $mm) $yonghu && echo $yonghu'用户创建成功' || echo $yonghu'用户创建失败'
                fi

}


hello7(){
	read -e -p "请输入你满意的主机名：" zjm
        hostnamectl set-hostname $zjm && echo '更改完成,请重新登录' || echo '更改失败'

}




echo
echo  "############################################"
echo  "#####          多功能脚本             ######"
echo  "############################################"
echo  "++++++++++++++++++++++++++++++++++++++++++++"
echo  "+    功能：                                +"
echo  "+        1.启动网卡                        +"
echo  "+        2.关闭SElinux                     +"
echo  "+        3.配置本地yum                     +"
echo  "+        4.安装软件                        +"
echo  "+        5.创建新用户和密码                +"
echo  "+        6.一件打印用户表格                +"
echo  "+        7.修改主机名                      +"
echo  "+        按其余任意键可直接退出退出        +"
echo  "+                                          +"
echo  "++++++++++++++++++++++++++++++++++++++++++++"
echo '-------------'
read -n1 -e -p "选择功能：" gn
echo
case $gn in
        1)
                hello1
		
        ;;
	2)
		hello2
		
	;;
	3)
		lsblk | grep '^sr0'
                if [ $? -eq 0 ]
                then
                        hello3
                else
                        echo '未找到sr0镜像文件不能给你建立缓存'
                fi
	
	;;
	4)
		hello4
		
	;;
	5)
		hello5
		
	;;
	6)
	awk -F: 'BEGIN{print "用户名\t\t\tUID\tGID\tSHELL"}{printf "%-25s%8-s%-7s%-10s\n",$1,$3,$4,$7}' /etc/passwd | sed G
		
	;;
	7)
		hello7
		
	;;
	*)
		exit
esac            
	echo
	echo '--------------------------------------'
	echo '本次操作已结束是否继续？'
	read -n1 -p "输入n为退出，其余任意键继续：" ry
	echo
	case $ry in
		[nN])
			exit
		;;
		*)
			bash $0
		;;
		  
	esac                          
