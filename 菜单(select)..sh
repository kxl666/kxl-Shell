#!/bin/bash
PS3="你的选择是 :" 
 
select i in 查看分区 磁盘信息 平均负载 内存情况 退出
do
       case "$i" in
        查看分区)
                 fdisk -l
                 ;;
        磁盘信息)
                 df -Th
                 ;;
        平均负载)
                 uptime
                 ;;
        内存情况)
                 free -m
                 ;;
            退出)
                 break
                 ;;
               *)
                 echo "error"
        esac
done
