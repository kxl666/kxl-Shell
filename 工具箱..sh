#!/bin/bash
#这是一个工具箱哦！

while :
do
cat <<-EOF
         #################################################
         #                                               #
         #               【欢迎使用工具箱】              #
         #                                               #
         #    选项                             功能      #
         #                                               # 
         #    【d】                    《 查看当前时间》 #                
         #                                               #
         #    【f】                    《 p  i  n  g  》 #
         #                                               #     
         #    【c】                    《  执行代码雨 》 #                                            
         #                                               #
         #    【i】                    《乘 法 口 诀 表》#                                        
         #                                               #
         #    【b】                    《执行俄罗斯方块》#                                          
         #                                               #
         #    【e】                     《  猜  数  字 》#                                         
         #                                               #
         #    【q】                     《     退出    》#    
         #################################################                                               
EOF

trap " " HUP INT TSTP
#while true
#do 
        echo -en "\e[1;31m  看完菜单后请输入: \e[0m"
        read -e  o

        case $o in 
        
        d|D)
           date 
           sleep 5
           #bash $0
          ;;
        f|F)
           bash /tmp/ping  
           #sleep 5
           #bash $0
          ;;
        c|C)
           cmatrix
           #sleep 5 
          # bash $0
          ;;
        i|I)
           bash /tmp/乘法口诀表 
           sleep 5
           #bash $0
          ;;
        b|B)
           bash /tmp/俄罗斯方块  
           #sleep 5
           #bash $0
          ;;

        e|E)
           bash /tmp/猜数字
           #sleep 5
           #bash $0
          ;;
        q|Q)
           break 
          ;;
        *)  
           echo " 请按要求输入"
           #bash $0
          ;;
esac
done
wait
           echo "欢迎下次光临" 
        
