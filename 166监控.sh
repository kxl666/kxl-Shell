#################################使用说明##########################################  
#1.修改bash_path、ora_bash_path路径                                               #     
#2.根据服务器上的链路选择需要调用的函数                                           #     
#3.适用于源端为ORACLE等;目标端为ORACLE、KAFKA等链路      #     
#4.源端为oracle时，需要将ora_bash_path=声明到ds目录，然后调用mon_oracl_ds函数     #     
#5.调用函数时，只需要在函数调用模块把#删除即可调用;不调用的函数必须在前面加上#注释#     
###################################################################################

line=0
times=`date "+%Y-%m-%d %H:%M:%S"`
bash_path=/data/dsg                         #################监控的目录
ora_bash_path=/data/dsg
no_mon_server="tysdm_ds4|tysdm_dt4"         ############不监控的链路


mon_dt()                 #################目标端监控函数
{
	rm -rm       /data/dsg/mon/result_yloader_dt.txt &>/dev/null  
	echo 
        echo -e -n  "+-----------------------------------------[\e[1;32m yloader \e[0m]-----------------------------------------\n"
	echo -e "   通道名     队列名        装载时间      积压文件数"
        for i in `ls -d $bash_path/*/*/log/log.yloader|grep -Ev $no_mon_server `
        do
                path=`echo $i|awk '{print substr($1,0,length($1)-s15)"rmp"}'`
		bash2_path=`echo $i|awk '{print substr($1,0,length($1)-15)}'`                

                yloader_v=`echo $i|awk '{print substr($1,0,length($1)-15)"bin/yloader -v|head -2|tail -1"}'`
                xagentd_v=`echo $i|awk '{print substr($1,0,length($1)-15)"bin/xagentd -v   |head -1"}'`   
                yloader=`eval $yloader_v|awk '{print "[y "$6"]"}'`
                xagentd=`eval $xagentd_v   |awk '{print "[n "$6"]"}'`
                
                server_name=`echo $i|awk -F "/" '{print $5}'`
                server_name2=`echo $i|awk -F "/" '{print $4}'`

                length_v1=${#server_name}
                length_v2=`expr 18 - $length_v1`

                xagentd_num=`ps -ef | grep $bash2_path | grep xagentd| wc -l`
                yxad_num=`ps -ef | grep $bash2_path | grep yxad| wc -l`
                yloader_num=`ps -ef | grep $bash2_path | grep yloader| wc -l`

                if [ $xagentd_num -ge 2 ] && [ $yxad_num -ge 1 ] && [ $yloader_num -ge 2 ]
                then
                        server_status="active"
                else
                        server_status="stop"
                fi

                if [ $length_v2 -gt 0 ]
                  then
                #    for k in `seq 1 $length_v2`
                #    do
                #   done
                fi

                echo -e -n "[ \033[37m$server_name\033[0m ]"

		num_total=0
		last_log_time=""
		last_log_sec=`date +%s`
                for j in `ls -l $path|grep real[0~9]*|awk '{print $9}'|sort`
                do

                        if [ ! -f $path/$j/cfg.*imp* ]
                          then
                            echo -n -e " [\e[1;36mreal0\e[0m] [\e[41;37;1;5m2020-10-01:00:00:00\e[0m] \e[\e[41;37;1;5m Not Found rmp/real0/cfg.*imp*\e[0m"
                            continue
                        fi

                        imp_file=`ls -ltr $path/$j/cfg.*imp*|awk '{print $9}'|tail -1`
                        v_imp=`cat $imp_file|column -t -s ,|awk '{print $1}'`
                        v_flag=`cat $imp_file|column -t -s ,|awk '{print $2}'`
                        v_time=`cat $imp_file|column -t -s ,|awk '{print $3}'`
                        time_len=`echo $v_time|awk '{print length($0)}'`
                        
                        if [ $time_len -eq 0 ]
                        then
                                v_time=$times
                        fi

                        if [ ! -f $path/$j/cfg.loaderno ]
                          then
                            echo -e " [\e[1;36mmdsd\e[0m] [\e[41;37;1;5m2020-10-01:00:00:00\e[0m] \e[\e[41;37;1;5m Not Found rmp/real0/cfg.loaderno\e[0m"
                            continue
                        fi
                        
                        v_rev=`[ -f $path/$j/cfg.loaderno ] && cat $path/$j/cfg.loaderno|awk '{print $2}'`
                        if [ "$v_rev" ]
                        then
                                num=`expr $v_rev - $v_imp`
                        else
                                num=E
                        fi

                        length_v1=${#num}
                        length_v2=`expr 6 - $length_v1`

                        if [ $length_v2 -gt 0 ]
                        then
                          for k in `seq 1 $length_v2`
                          do
                            num=" $num"
                          done
                        fi

                        kafka_flag=`cat $path/../config/yloader.ini|grep -e "pack_for_java=y"|wc -l`
                        if [ $kafka_flag -gt 0 ]; then
                          #yxad_key=`cat $path/../config/_service.ini|grep service|awk -F "=" '{print substr($2,2,length($2)-2)}'`
                          #yxad_path_flag=`ps -ef|grep -w $yxad_key|grep DPath|awk -F "DPath=" '{print $2}'|awk '{print $1}'|wc -l`
                          #yxad_path=`ps -ef|grep -w $yxad_key|grep DPath|awk -F "DPath=" '{print $2}'|awk '{print $1}'`
                          yxad_path=`echo $i|awk '{print substr($1,0,length($1)-15)"Jddm_socket_kafka13_20221027"}'`
                          #if [ $yxad_path_flag -gt 0 ]; then
                                  yxad_val=`tail -3000 $yxad_path/logs/info.log|grep -v JddmDataOperationFromSourceBytes|grep XF1|tail -1|awk '{print substr($1,2,19),substr($6,5,length($6)-5)}'`
                                 yxad_time=`echo $yxad_val|awk '{print $1}'`
                                  yxad_num=`echo $yxad_val|awk '{print $2}'`
                            yxad_cache_num=`expr $v_rev - $yxad_num`
                          length_v1=${#yxad_cache_num}
                          length_v2=`expr 6 - $length_v1`
                          if [ $length_v2 -gt 0 ]
                          thenP
                            for k in `seq 1 $length_v2`
                            do
                              yxad_cache_num=" $yxad_cache_num"
                            done
                          fi
                          #else
                             #yxad_time="Yxad_Java Not Run!!"
                             #yxad_cache_num="   E  "
                          #fi
                  length_v1=${#yxad_time}
                  if [ $length_v1 -lt 10 ]
                  then
                    yxad_time="2020-10-01:00:00:00"
                    yxad_log_time=`echo $yxad_time|awk -F':' '{print $1,$2":"$3":"$4}'`
                  else
                    yxad_log_time=`echo $yxad_time|awk -F':' '{print $1,$2":"$3":"$4}'`
                  fi

                  v_time=`echo $v_time|sed "s/ /:/g"`
                  length_v1=${#v_time}
                  if [ $length_v1 -lt 10 ]
                  then
                    v_time="2020-10-01:00:00:00"
                    log_time=`echo $v_time|awk -F':' '{print $1,$2":"$3":"$4}'`
                  else
                    log_time=`echo $v_time|awk -F':' '{print $1,$2":"$3":"$4}'`
                  fi

                  dt_log_sec=`date +%s -d "${log_time}"`

                  system_now_sec=`date +%s`

                  if [ `expr $system_now_sec - $dt_log_sec` -gt 590 ] ;then
                        echo -e -n " [\e[1;36m$j\e[0m] [\e[41;37;1;5m$log_time\e[0m] \e[4;1;47;31m $num \e[0m [\e[1;36mYxad_Java\e[0m] [\e[1;33m$yxad_log_time\e[0m] \e[4;1;47;31m $yxad_cache_num \e[0m"
                  else
                        echo -e -n " [\e[1;36m$j\e[0m] [\e[1;33m$log_time\e[0m] \e[4;1;47;31m $num \e[0m [\e[1;36mYxad_Java\e[0m] [\e[1;33m$yxad_log_time\e[0m] \e[4;1;47;31m $yxad_cache_num \e[0m"
                  fi

                else
                        v_time=`echo $v_time|sed "s/ /:/g"`
                        length_v1=${#v_time}
                        if [ $length_v1 -lt 10 ]
                        then
                          v_time="2020-10-01:00:00:00"
                          log_time=`echo $v_time|awk -F':' '{print $1,$2":"$3":"$4}'`
                        else
                          log_time=`echo $v_time|awk -F':' '{print $1,$2":"$3":"$4}'`
                        fi

                        dt_log_sec=`date +%s -d "${log_time}"`

                        system_now_sec=`date +%s`

                        if [[ `expr $system_now_sec - $dt_log_sec` -gt 590 ]] ;then
                          echo -e -n " [\e[1;36m$j\e[0m] [\e[41;37;1;5m$log_time\e[0m] \e[4;1;47;31m $num \e[0m"
                        else
                          echo -e -n " [\e[1;36m$j\e[0m] [\e[1;33m$log_time\e[0m] \e[4;1;47;31m $num \e[0m"
                        fi
                fi
		num_total=$((num_total+num))
		if [ ${last_log_sec} -le ${dt_log_sec} ] 
		then
			last_log_sec=$last_log_sec
			last_log_time=$last_log_time
		else
			last_log_sec=$dt_log_sec
			last_log_time=$log_time
		fi
                done
		last_log_time=`echo $last_log_time | awk '{print $1":"$2}'`
		echo "$server_name $server_status $last_log_time $num_total" >> /data/dsg/mon/result_yloader_dt.txt
                echo
                tail -5000 $i|grep -Ev "^$|wait|OK|y1_m"|tail -$line
        done
}



mon_oracl_ds()
{
	rm /data/dsg/mon/result_ds.txt
	server_status=""
        echo "+--------------------------------------------------------------------------------------------"
        echo -e "|  \e[4;1;47;31m Work_path: $bash_path  \e[0m   $mon_path  "
        echo "+--------------------------------------------------------------------------------------------"
        for i in `ls -d $ora_bash_path/*/*/log/log.vagentd | grep -v dt|grep -v tysdm_ds4`
        do
                path=`echo $i|awk '{print substr($1,0,length($1)-15)"/rmp"}'`
                va_v=`echo $i|awk '{print substr($1,0,length($1)-15)"/bin/vagentd -v "}'`
		bash2_path=`echo $i|awk '{print substr($1,0,length($1)-15)}'`

                vagentd=`eval $va_v | grep SuperSync | head -1|awk -F "(" '{print $NF}'|awk -F "," '{print "[vagentd "$1"]"}'`
                server_name=`echo $i|awk -F "/" '{print $5}'`
		#server_name=`echo $i`		

                length_v1=${#server_name}
                length_v2=`expr 45 - $length_v1`

                vagentd_num=`ps -ef | grep $bash2_path | grep vagentd| wc -l`
                sender_num=`ps -ef | grep $bash2_path | grep sender| wc -l`
                dbpsd_num=`ps -ef | grep $bash2_path | grep dbpsd| wc -l`

                if [ $vagentd_num -ge 2 ] && [ $sender_num -ge 2 ] && [ $dbpsd_num -ge 1 ]
                then
                        server_status="active"
                else
                        server_status="stop"
                fi

                if [ $length_v2 -gt 0 ]
                  then
                    for k in `seq 1 $length_v2`
                    do
                      server_name="$server_name"
                   done
                fi

                echo -e -n "[ \033[37m$server_name\033[0m ]"
                echo -e -n "\e[35m$vagentd\e[0m"    

                ds_path=`echo $i|awk '{print substr($1,0,length($1)-15)}'|sed 's/dt/ds/'`
                ds_log_time=`tail -100 $ds_path/log/log.vagentd|grep "delay:"|tail -1|awk '{print $7}'`
                xout=`[ -f $ds_path/rmp/2.cfg.senderno ] && cat $ds_path/rmp/2.cfg.senderno|awk '{print $1}'`
                xsnd_0=`[ -f $ds_path/rmp/2.cfg.senderno ] && cat $ds_path/rmp/2.cfg.senderno|awk '{print $2}'`
                if [ "$xout" -a "$xsnd_0" ];then
                        ds_delayFile=`expr $xsnd_0 - $xout`
                else
                        ds_delayFile=0
                fi

                length_v1=${#ds_delayFile}
                length_v2=`expr 6 - $length_v1`

                if [ $length_v2 -gt 0 ]
                  then
                    for k in `seq 1 $length_v2`
                    do
                      ds_delayFile=" $ds_delayFile"
                   done
                fi
                log_time=`echo $ds_log_time|awk -F':' '{print $1,$2":"$3":"$4}'`
                ds_log_sec=`date +%s -d "${log_time}"`

                system_now_sec=`date +%s`

                if [[ `expr $system_now_sec - $ds_log_sec` -gt 599 ]] ;then
                        #echo -e -n " [\e[1;36mvagentd\e[0m] [\e[1;31m$ds_log_time\e[0m] \e[4;1;47;31m $ds_delayFile \e[0m"
			echo -n -e " [\e[1;36mvagentd\e[0m][\e[41;37;1;5m$ds_log_time\e[0m] \e[\e[41;37;1;5m $ds_delayFile\e[0m"
                else
                        echo -e -n " [\e[1;36mvagentd\e[0m] [\e[1;33m$ds_log_time\e[0m] \e[4;1;47;31m $ds_delayFile \e[0m"
                fi
                echo
		   ds_delayFile=`echo $ds_delayFile | tr -d ' '`
		echo "$server_name $server_status $ds_log_time $ds_delayFile" >> /data/dsg/mon/result_ds.txt
        done
}

mon_oracl_dt()                
{
	rm /data/dsg/mon/result_loader_dt.txt
	server_status=""
        echo "+--------------------------------------------------------------------------------------------"
        echo -e "|  \e[4;1;47;31m Work_path: $bash_path/  \e[0m                          $mon_path"
	echo 
        echo -e -n  "+-----------------------------------------[\e[1;32m loader \e[0m]-----------------------------------------\n"
        for i in `ls -d $ora_bash_path/*/*/log/log.vagentd|grep -Ev $no_mon_server | grep -v _ds`
        do
                path=`echo $i|awk '{print substr($1,0,length($1)-15)"rmp"}'`
                log_path=`echo $i|awk '{print substr($1,0,length($1)-15)"log"}'`
		bash2_path=`echo $i|awk '{print substr($1,0,length($1)-15)}'`

                vagentd_v=`echo $i|awk '{print substr($1,0,length($1)-15)"bin/vagentd -v   |head -3 | tail -1"}'`
                vagentd=`eval $vagentd_v | grep SuperSync | head -1|awk -F "(" '{print $NF}'|awk -F "," '{print "[vagentd "$1"]"}'`
                loader_v=`echo $i|awk '{print substr($1,0,length($1)-15)"bin/loader -v   |head -3 | tail -1"}'`
                loader=`eval $vagentd_v | grep SuperSync | head -1|awk -F "(" '{print $NF}'|awk -F "," '{print "[loader "$1"]"}'`
                server_name=`echo $i|awk -F "/" '{print $5}'`
                #server_name=`echo $i`
		server_name2=`echo $i|awk -F "/" '{print $4}'`

                length_v1=${#server_name}
                length_v2=`expr 18 - $length_v1`

                if [ $length_v2 -gt 0 ]
                  then
                    #for k in `seq 1 $length_v2`
                    #do
			if [ $server_name2 == ora2ora ]
			  then
		  	    if [ $server_name == "dt" ]
			      then
				 server_name="lsdb_${server_name}1"
			      else				
				 server_name="lsdb_$server_name"	
			    fi	
			  else
			    server_name="$server_name"
			fi
                    #done
                fi

		vagentd_num=`ps -ef | grep $bash2_path | grep vagentd| wc -l`
		laoder_r_num=`ps -ef | grep $bash2_path | grep "loader -r"| wc -l`
		laoder_s_num=`ps -ef | grep $bash2_path | grep "loader -s"| wc -l`

		if [ $vagentd_num -ge 2 ] && [ $laoder_r_num -ge 2 ] && [ $laoder_s_num -ge 2 ]
		then
			server_status="active"
		else
			server_status="stop"
		fi

                echo -e -n "[ \033[37m$server_name\033[0m ] "
                echo -e -n "\e[35m$vagentd\e[0m "
                echo -e -n "\e[32m$loader\e[0m"
                for j in `ls -l $path|grep real[0~9]*|awk '{print $9}'|sort`
                do
                        if [ ! -f $path/$j/cfg.loaderno ]
                          then
                            echo -n -e " [\e[1;36mxagentd\e[0m] [\e[41;37;1;5m2020-10-01:00:00:00\e[0m] \e[\e[41;37;1;5m Not Found rmp/real0/cfg.loaderno\e[0m"
                            continue
                        fi

                        v_imp=`[ -f $path/$j/cfg.loaderno ] && cat $path/$j/cfg.loaderno|awk '{print $1}'`
                        v_rev=`[ -f $path/$j/cfg.loaderno ] && cat $path/$j/cfg.loaderno|awk '{print $2}'`

                        if [ "$v_rev" ]
                        then
                                dt_delayFile=`expr $v_rev - $v_imp`
                        else
                                dt_delayFile=E
                        fi

                	length_v1=${#dt_delayFile}
                	length_v2=`expr 6 - $length_v1`

                	if [ $length_v2 -gt 0 ]
                   	then
                    		for k in `seq 1 $length_v2`
                    		do
                      			dt_delayFile=" $dt_delayFile"
                   		done
                	fi

                        n=`echo $j | grep -o "[0-9]"`
                        dt_log_time=`tail -n 100 $log_path/log.r${n} | grep "Time " | sort | tail -n 1 | awk '{print $5" "$6}'`

                        dt_log_sec=`date +%s -d "${dt_log_time}"`
                        system_now_sec=`date +%s`

                        if [ `expr $system_now_sec - $dt_log_sec` -gt 599 ] ;then
                                echo -n -e " [\e[1;36m$j\e[0m][\e[41;37;1;5m$dt_log_time\e[0m] \e[\e[41;37;1;5m $dt_delayFile\e[0m"
                        else
                                echo -e -n " [\e[1;36m$j\e[0m] [\e[1;33m$dt_log_time\e[0m] \e[4;1;47;31m $dt_delayFile \e[0m"
                        fi
                                
                done
                echo
		dt_log_time=`echo $dt_log_time| awk '{print $1":"$2}'`
		dt_delayFile=`echo $dt_delayFile | tr -d ' '`
		echo "$server_name $server_status $dt_log_time $dt_delayFile" >> /data/dsg/mon/result_loader_dt.txt
        
        done
}

##############################################函数调用模块############################################
while [ true ]
do
        mon_path=`echo $bash_path|awk -F "/" '{print $2}'`
        mon_path=`df -h|grep "/$mon_path$"`
        clear
	#echo "+------------------------------------------源端监控------------------------------------------"
        #mon_oracl_ds    #####调用mon_oracl_ds函数
	#echo
	#echo "+------------------------------------------目标监控------------------------------------------"
	#mon_oracl_dt   #####调用mon_oracl_dt函数
        mon_dt          #####调用mon_dt()函数
        echo "+--------------------------------------------------------------------------------------------"
        free -h
        echo "+--------------------------------------------------------------------------------------------"
        sleep 30
done
