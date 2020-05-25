#!/bin/bash
config_static_tcp_ip() {
nmcli connection modify $1 ipv4.addresses $2 ipv4.gateway $3 ipv4.dns $4 autoconnect yes
systemctl restart NetworkManager network
}
if [[ $# -ne 4 ]]; then
echo "该脚本的执行语法格式为：$0 网卡设备名 IP地址 网关IP DNS指向IP"
exit
fi
config_static_tcp_ip "$1" "$2" "$3" "$4"
