#################################使用说明##########################################  
#1.修改bash_path、ora_bash_path路径                                               #     
#2.根据服务器上的链路选择需要调用的函数                                           #     
#3.适用于源端为TDSQL、TBASE、ORACLE等;目标端为TDSQL、TBASE、KAFKA等链路           #     
#4.源端为oracle时，需要将ora_bash_path=声明到ds目录，然后调用mon_oracl_ds函数     #     
#5.调用函数时，只需要在函数调用模块把#删除即可调用;不调用的函数必须在前面加上#注释#     
###################################################################################

line=0
times=`date "+%Y-%m-%d %H:%M:%S"`
bash_path=/dbb/sync/*gd                         #################省份链路路径
ora_bash_path=/dbb/sync/xgd/psz02/psz02_001/ds_psz02_001
no_mon_server="pzz26|pzz27|pzz31|pzz30"         ############不监控的链路

mon_ds()                                        #################源端监控函数
{
      echo "+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
      echo -e "|  \e[4;1;47;31m Work_path: $bash_path/  \e[0m   $mon_path  "
      echo "+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
      for k in `ls -d $bash_path`
        do
        for i in `ls -d $k/*/*/ds*/log/log.mdsd|grep -Ev $no_mon_server`
        do
                path=`echo $i|awk '{print substr($1,0,length($1)-13)"/rmp"}'`
                server_name=`echo $i|awk -F "/" '{print $6}'`
                length_v1=${#server_name}
                length_v2=`expr 18 - $length_v1`

                if [ $length_v2 -gt 0 ]
                  then
                    for k in `seq 1 $length_v2`
                    do
                      server_name=" $server_name"
                   done
                fi

                echo -e -n "[ \033[37m$server_name\033[0m ]"
                echo -e -n "\e[36m$mdsd\e[0m\e[35m$nfmd\e[0m\e[34m$pmon\e[0m"
                ds_path=`echo $i|awk '{print substr($1,0,length($1)-13)}'|sed 's/dt/ds/'`

                if [ ! -f $ds_path/rmp/real0/xout.no ]
                  then
                    echo -e " [\e[1;36mmdsd\e[0m] [\e[41;37;1;5m2020-10-01:00:00:00\e[0m] \e[\e[41;37;1;5m Not Found rmp/real0/xout.no\e[0m"
                    continue
                fi

                ds_log_time=`tail -10000 $ds_path/log/log.mdsd|grep "log time:"|tail -1|awk '{print $5}'|sed "s/,//g"`
                ds_delay_file=`tail -10000 $ds_path/log/log.mdsd|grep "log time:"|tail -1|awk '{print $(NF)}'|sed "s/f//g"`
                ds_delay_second=`tail -10000 $ds_path/log/log.mdsd|grep "log time:"|tail -1|awk '{print $(NF-1)}'|sed "s/s//g"|sed "s/,//g"`
                ds_delay_file_flag=`tail -10000 $ds_path/log/log.mdsd|grep ", delay "|wc -l`
                xout=`[ -f $ds_path/rmp/real0/xout.no ] && cat $ds_path/rmp/real0/xout.no 2>/dev/null|awk '{print $1}'`
                xsnd_0=`[ -f $ds_path/rmp/real0/xsnd_0.no ] && cat $ds_path/rmp/real0/xsnd_0.no 2>/dev/null||awk '{print $1}'`
                if [ "$xout" -a "$xsnd_0" ];then
                        ds_delayFile=`expr $xout - $xsnd_0`
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

                length_v1=${#ds_delay_second}
                length_v2=`expr 6 - $length_v1`

                if [ $length_v2 -gt 0 ]
                  then
                    for k in `seq 1 $length_v2`
                    do
                      ds_delay_second=" $ds_delay_second"
                   done
                fi

                length_v1=${#ds_delay_file}
                length_v2=`expr 6 - $length_v1`

                if [ $length_v2 -gt 0 ]
                  then
                    for k in `seq 1 $length_v2`
                    do
                      ds_delay_file=" $ds_delay_file"
                   done
                fi

                length_v1=${#ds_log_time}
                if [ $length_v1 -lt 10 ]
                then
                  ds_log_time="2020-10-01:00:00:00"
                  log_time=`echo $ds_log_time|awk -F':' '{print $1,$2":"$3":"$4}'`
                else
                  log_time=`echo $ds_log_time|awk -F':' '{print $1,$2":"$3":"$4}'`
                fi

                ds_log_sec=`date +%s -d "${log_time}"`

                system_now_sec=`date +%s`
                if [ $ds_delay_file_flag -gt 0 ] ;then
                  if [ `expr $system_now_sec - $ds_log_sec` -gt 590 ] ;then
                        echo -e -n " [\e[1;36mmdsd\e[0m] [\e[1;31m$ds_log_time\e[0m] [\e[41;37;1;5m${ds_delay_second}s\e[0m] [\e[41;37;1;5m${ds_delay_file}f\e[0m] \e[4;1;47;31m $ds_delayFile \e[0m"
                  else
                        echo -e -n " [\e[1;36mmdsd\e[0m] [\e[1;33m$ds_log_time\e[0m] [\e[1;34m${ds_delay_second}s\e[0m] [\e[1;35m${ds_delay_file}f\e[0m] \e[4;1;47;31m $ds_delayFile \e[0m"
                  fi
                else
                  if [ `expr $system_now_sec - $ds_log_sec` -gt 590 ] ;then
                        echo -e -n " [\e[1;36mmdsd\e[0m] [\e[41;37;1;5m$ds_log_time\e[0m] \e[4;1;47;31m $ds_delayFile \e[0m"
                  else
                        echo -e -n " [\e[1;36mmdsd\e[0m] [\e[1;33m$ds_log_time\e[0m] \e[4;1;47;31m $ds_delayFile \e[0m"
                  fi
                fi
                echo

        done
      done
}

mon_dt()                 #################目标端监控函数
{
        echo "+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
        echo -e "|  \e[4;1;47;31m Work_path: $bash_path/  \e[0m                          $mon_path"
        echo "+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
        for i in `ls -d $bash_path/*/*/*/log/log.yloader|grep -Ev $no_mon_server`
        do
                path=`echo $i|awk '{print substr($1,0,length($1)-15)"rmp"}'`
                
                yloader_v=`echo $i|awk '{print substr($1,0,length($1)-15)"bin/yloader -v|head -2|tail -1"}'`
                   nfmd_v=`echo $i|awk '{print substr($1,0,length($1)-15)"bin/nfmd -v   |head -1"}'`
                   pmon_v=`echo $i|awk '{print substr($1,0,length($1)-15)"bin/pmon -v   |head -1"}'`
                   
                yloader=`eval $yloader_v|awk '{print "[y "$6"]"}'`
                   nfmd=`eval $nfmd_v   |awk '{print "[n "$6"]"}'`
                   pmon=`eval $pmon_v   |awk '{print "[p "$6"]"}'`
                
                server_name=`echo $i|awk -F "/" '{print $6}'`

                length_v1=${#server_name}
                length_v2=`expr 18 - $length_v1`

                if [ $length_v2 -gt 0 ]
                  then
                    for k in `seq 1 $length_v2`
                    do
                      server_name=" $server_name"
                   done
                fi

                echo -e -n "[ \033[37m$server_name\033[0m ]"
                #echo -e -n "\e[36m$yloader\e[0m\e[35m$nfmd\e[0m\e[34m$pmon\e[0m"

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

                        kafka_flag=`cat $path/../config/yloader.ini|grep -e "^pack_for_java=y"|wc -l`
                        if [ $kafka_flag -gt 0 ]; then
                          yxad_key=`cat $path/../config/_service.ini|grep service|awk -F "=" '{print substr($2,2,length($2)-2)}'`
                          yxad_path_flag=`ps -ef|grep -w $yxad_key|grep DPath|awk -F "DPath=" '{print $2}'|awk '{print $1}'|wc -l`
                          yxad_path=`ps -ef|grep -w $yxad_key|grep DPath|awk -F "DPath=" '{print $2}'|awk '{print $1}'`

                          if [ $yxad_path_flag -gt 0 ]; then
                                  yxad_val=`tail -3000 $yxad_path/logs/info.log|grep -v JddmDataOperationFromSourceBytes|grep XF1|tail -1|awk '{print substr($1,2,19),substr($6,5,length($6)-5)}'`
                                 yxad_time=`echo $yxad_val|awk '{print $1}'`
                                  yxad_num=`echo $yxad_val|awk '{print $2}'`
                            yxad_cache_num=`expr $v_rev - $yxad_num`

                          length_v1=${#yxad_cache_num}
                          length_v2=`expr 6 - $length_v1`
                          if [ $length_v2 -gt 0 ]
                          then
                            for k in `seq 1 $length_v2`
                            do
                              yxad_cache_num=" $yxad_cache_num"
                            done
                          fi
                          else
                             yxad_time="Yxad_Java Not Run!!"
                             yxad_cache_num="   E  "
                          fi

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

                        if [ `expr $system_now_sec - $dt_log_sec` -gt 590 ] ;then
                          echo -e -n " [\e[1;36m$j\e[0m] [\e[41;37;1;5m$log_time\e[0m] \e[4;1;47;31m $num \e[0m"
                        else
                          echo -e -n " [\e[1;36m$j\e[0m] [\e[1;33m$log_time\e[0m] \e[4;1;47;31m $num \e[0m"
                        fi
                fi

                done
                echo
                tail -5000 $i|grep -Ev "^$|wait|OK|y1_m"|tail -$line
        done
}

mon_all()               #######同时监控同一台服务器的源端和目标端函数
{
        echo "+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
        echo -e "|  \e[4;1;47;31m Work_path: $bash_path/  \e[0m   $mon_path  "
        echo "+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
        for i in $sp_path `ls -d $bash_path/*/*/*/log/log.yloader|grep -Ev $no_mon_server`
        do
                path=`echo $i|awk '{print substr($1,0,length($1)-15)"rmp"}'`
                server_name=`echo $i|awk -F "/" '{print $6}'`

                length_v1=${#server_name}
                length_v2=`expr 18 - $length_v1`

                if [ $length_v2 -gt 0 ]
                  then
                    for k in `seq 1 $length_v2`
                    do
                      server_name=" $server_name"
                   done
                fi

                echo -e -n "[ \033[37m$server_name\033[0m ]"

                ds_path=`echo $i|awk '{print substr($1,0,length($1)-16)}'|sed 's/dt/ds/'`

                if [ $server_name = dt_pzz25_001 ]
                then
                  ds_path=$no_path
                fi

                if [ ! -f $ds_path/rmp/real0/xout.no ]
                  then
                    echo -e " [\e[1;36mmdsd\e[0m] [\e[41;37;1;5m2020-10-01:00:00:00\e[0m] \e[\e[41;37;1;5m Not Found rmp/real0/xout.no\e[0m"
                    continue
                fi

                ds_log_time=`tail -10000 $ds_path/log/log.mdsd|grep "log time:"|tail -1|awk '{print $5}'|sed "s/,//g"`
                ds_delay_file=`tail -10000 $ds_path/log/log.mdsd|grep "log time:"|tail -1|awk '{print $(NF)}'|sed "s/f//g"`
                ds_delay_second=`tail -10000 $ds_path/log/log.mdsd|grep "log time:"|tail -1|awk '{print $(NF-1)}'|sed "s/s//g"|sed "s/,//g"`
                ds_delay_file_flag=`tail -10000 $ds_path/log/log.mdsd|grep ", delay "|wc -l`
                xout=`[ -f $ds_path/rmp/real0/xout.no ] && cat $ds_path/rmp/real0/xout.no|awk '{print $1}'`
                xsnd_0=`[ -f $ds_path/rmp/real0/xsnd_0.no ] && cat $ds_path/rmp/real0/xsnd_0.no|awk '{print $1}'`
                if [ "$xout" -a "$xsnd_0" ];then
                        ds_delayFile=`expr $xout - $xsnd_0`
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

                length_v1=${#ds_delay_second}
                length_v2=`expr 6 - $length_v1`

                if [ $length_v2 -gt 0 ]
                  then
                    for k in `seq 1 $length_v2`
                    do
                      ds_delay_second=" $ds_delay_second"
                   done
                fi

                length_v1=${#ds_delay_file}
                length_v2=`expr 6 - $length_v1`

                if [ $length_v2 -gt 0 ]
                  then
                    for k in `seq 1 $length_v2`
                    do
                      ds_delay_file=" $ds_delay_file"
                   done
                fi


                log_time=`echo $ds_log_time|awk -F':' '{print $1,$2":"$3":"$4}'`


                length_v1=${#ds_log_time}
                if [ $length_v1 -lt 10 ]
                then
                  ds_log_time="2020-10-01:00:00:00"
                  log_time=`echo $ds_log_time|awk -F':' '{print $1,$2":"$3":"$4}'`
                else
                  log_time=`echo $ds_log_time|awk -F':' '{print $1,$2":"$3":"$4}'`
                fi

                ds_log_sec=`date +%s -d "${log_time}"`

                system_now_sec=`date +%s`
                if [ $ds_delay_file_flag -gt 0 ] ;then
                  if [ `expr $system_now_sec - $ds_log_sec` -gt 590 ] ;then
                        echo -e -n " [\e[1;36mmdsd\e[0m] [\e[1;31m$ds_log_time\e[0m] [\e[41;37;1;5m${ds_delay_second}s\e[0m] [\e[41;37;1;5m${ds_delay_file}f\e[0m] \e[4;1;47;31m $ds_delayFile \e[0m"
                  else
                        echo -e -n " [\e[1;36mmdsd\e[0m] [\e[1;33m$ds_log_time\e[0m] [\e[1;34m${ds_delay_second}s\e[0m] [\e[1;35m${ds_delay_file}f\e[0m] \e[4;1;47;31m $ds_delayFile \e[0m"
                  fi
                else
                  if [ `expr $system_now_sec - $ds_log_sec` -gt 590 ] ;then
                        echo -e -n " [\e[1;36mmdsd\e[0m] [\e[41;37;1;5m$ds_log_time\e[0m] \e[4;1;47;31m $ds_delayFile \e[0m"
                  else
                        echo -e -n " [\e[1;36mmdsd\e[0m] [\e[1;33m$ds_log_time\e[0m] \e[4;1;47;31m $ds_delayFile \e[0m"
                  fi
                fi
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

                        kafka_flag=`cat $path/../config/yloader.ini|grep -e "^pack_for_java=y"|wc -l`
                        if [ $kafka_flag -gt 0 ]; then
                          yxad_key=`cat $path/../config/_service.ini|grep service|awk -F "=" '{print substr($2,2,length($2)-2)}'`
                          yxad_path_flag=`ps -ef|grep -w $yxad_key|grep DPath|awk -F "DPath=" '{print $2}'|awk '{print $1}'|wc -l`
                          yxad_path=`ps -ef|grep -w $yxad_key|grep DPath|awk -F "DPath=" '{print $2}'|awk '{print $1}'`

                          if [ $yxad_path_flag -gt 0 ]; then
                                  yxad_val=`tail -3000 $yxad_path/logs/info.log|grep -v JddmDataOperationFromSourceBytes|grep XF1|tail -1|awk '{print substr($1,2,19),substr($6,5,length($6)-5)}'`
                                 yxad_time=`echo $yxad_val|awk '{print $1}'`
                                  yxad_num=`echo $yxad_val|awk '{print $2}'`
                            yxad_cache_num=`expr $v_rev - $yxad_num`

                          length_v1=${#yxad_cache_num}
                          length_v2=`expr 6 - $length_v1`
                          if [ $length_v2 -gt 0 ]
                          then
                            for k in `seq 1 $length_v2`
                            do
                              yxad_cache_num=" $yxad_cache_num"
                            done
                          fi
                          else
                             yxad_time="Yxad_Java Not Run!!"
                             yxad_cache_num="   E  "
                          fi

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

                        if [ `expr $system_now_sec - $dt_log_sec` -gt 590 ] ;then
                          echo -e -n " [\e[1;36m$j\e[0m] [\e[41;37;1;5m$log_time\e[0m] \e[4;1;47;31m $num \e[0m"
                        else
                          echo -e -n " [\e[1;36m$j\e[0m] [\e[1;33m$log_time\e[0m] \e[4;1;47;31m $num \e[0m"
                        fi
                fi
                done
                echo
                tail -5000 $i|grep -Ev "^$|wait|OK|y1_m"|tail -$line
        done
}

mon_oracl_ds()
{
        echo "+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
        echo -e "|  \e[4;1;47;31m Work_path: $bash_path/  \e[0m   $mon_path  "
        echo "+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
        for i in `ls -d $ora_bash_path/log/log.vagentd`
        do
                path=`echo $i|awk '{print substr($1,0,length($1)-15)"/rmp"}'`
                va_v=`echo $i|awk '{print substr($1,0,length($1)-15)"/bin/vagentd -v "}'`
                pmon_v=`echo $i|awk '{print substr($1,0,length($1)-15)"/bin/pmon -v       |head -1"}'`
                pmon=`eval $pmon_v |awk '{print "[p "$6"]"}'`
                vagentd=`eval $va_v | grep SuperSync | head -1|awk -F "(" '{print $NF}'|awk -F "," '{print "[v "$1"]"}'`
                server_name=`echo $i|awk -F "/" '{print $6}'`

                length_v1=${#server_name}
                length_v2=`expr 45 - $length_v1`

                if [ $length_v2 -gt 0 ]
                  then
                    for k in `seq 1 $length_v2`
                    do
                      server_name=" $server_name"
                   done
                fi

                echo -e -n "[ \033[37m$server_name\033[0m ]"
                echo -e -n "\e[35m$pmon\e[0m \e[35m$vagentd\e[0m"    

                ds_path=`echo $i|awk '{print substr($1,0,length($1)-15)}'|sed 's/dt/ds/'`
                ds_log_time=`tail -100 $ds_path/log/log.vagentd|grep "delay"|tail -1|awk '{print $7}'`
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

                if [ `expr $system_now_sec - $ds_log_sec` -gt 599 ] ;then
                        echo -e -n " [\e[1;36mvagentd\e[0m] [\e[1;31m$ds_log_time\e[0m] \e[4;1;47;31m $ds_delayFile \e[0m"
                else
                        echo -e -n " [\e[1;36mvagentd\e[0m] [\e[1;33m$ds_log_time\e[0m] \e[4;1;47;31m $ds_delayFile \e[0m"
                fi
                echo
        done
}

##############################################函数调用模块############################################
while [ true ]
do
        mon_path=`echo $bash_path|awk -F "/" '{print $2}'`
        mon_path=`df -h|grep "/$mon_path$"`
        clear
        #mon_oracl_ds    #####调用mon_oracl_ds函数
        #mon_ds          #####调用mon_ds()函数
        #mon_dt          #####调用mon_dt()函数
        #mon_all         #####调用mon_all()函数
        echo "+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
        free -m
        echo "+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
        sleep 30
done