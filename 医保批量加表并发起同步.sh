#!/bin/bash

port_id=0
path_id=0

#批量修改mds.ini 新增同步表
find /data/dsg/tdsql-oracle/ybdy* -name mds.ini | egrep -v "(bin2022|bin)" | egrep -v "(25140|25032|ybdy_25101/set10_ds)" | awk '{print "sed -rn  \"s/'RLTS_TRAF_INFO_D','REFL_APPY_QUERY_D','OPSP_ASSIGN_QUOTA','OPSP_REG_QUERY_D','TWO_DISE_REG_D','DIS_OUT_C'/'REFL_APPY_QUERY_D','OPSP_ASSIGN_QUOTA','OPSP_REG_QUERY_D','TWO_DISE_REG_D','DIS_OUT_C','PSN_CRSP_RLTS_D'/g\"",$1}'

find /data/dsg/tdsql-oracle/ybdy* -name mds.ini | egrep -v "(bin2022|bin)" | egrep -v "(25140|25032|ybdy_25101/set10_ds)" | awk '{print "sed -rn \"s/RLTS_TRAF_INFO_D/PSN_CRSP_RLTS_D/g\"",$1}'

find /data/dsg/tdsql-oracle/ybdy* -name mds.ini | egrep -v "(bin2022|bin)" | egrep -v "(25140|25032|ybdy_25101/set10_ds)" | awk '{print "sed -rn \"s/'REFL_APPY_QUERY_D','OPSP_ASSIGN_QUOTA','OPSP_REG_QUERY_D','TWO_DISE_REG_D','DIS_OUT_C','PSN_CRSP_RLTS_D'/'RLTS_TRAF_INFO_D','REFL_APPY_QUERY_D','OPSP_ASSIGN_QUOTA','OPSP_REG_QUERY_D','TWO_DISE_REG_D','DIS_OUT_C','PSN_CRSP_RLTS_D'/g\"",$1}'

#批量停止程序
ls -ltrd /data/dsg/tdsql-oracle/ybdy*/set*ds/scripts/stop_mdsd | awk '{print "sh ",$9}'

#批量换程序包
ls -ltrd /data/dsg/tdsql-oracle/ybdy*/set*ds/bin | awk '{print "cp -r /data/dsg/tdsql-oracle/soft/mdsd_bak/* ",$9}'

#批量启动程序
ls -ltrd /data/dsg/tdsql-oracle/ybdy*/set*ds/scripts/start_mdsd | awk '{print "sh ",$9}'

#发起同步
find /data/dsg/tdsql-oracle/ybdy* -name mds.ini | egrep -v "(bin2022|bin)" | awk -F"/" '{print $1"/"$2"/"$3"/"$4"/"$5"/"$6"/bin/mdsc"}' >mdsd_path

while read path; do
  for port in $(find /data/dsg/tdsql-oracle/ybdy* -name mds.ini | egrep -v "(bin2022|bin)" | xargs sed -rn '/# MDS listener port/,+1p' | grep port= | awk -F'=' '{print $2}'); do
    if [ $path_id == $port_id ]; then
      echo $path $port >>mdsd_all
    fi
    let port_id+=1
  done
  let path_id+=1
  let port_id=0
done < <(cat mdsd_path)

while read all; do
  expect <<EOF
spawn $all 

expect "===>" { send "q\n" }

expect eof
EOF
done < <(cat mdsd_all)

rm mdsd_all
