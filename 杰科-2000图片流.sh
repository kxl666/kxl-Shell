#!/bin/bash

#获取所有摄像头id

curl --location --request GET 'http://100.119.30.20:11180/business/api/camera?predecessor_id=2&depth=5' --header 'session_id: 127096891@wuhanshizhedt_1563622360' | egrep -o "\"id\":\"[0-9]{1,}" >7.txt

#开始查询在线摄像头id

while read line 
do
echo "{
    \"condition\": {
        \"camera_ids\": ["$line"]
    },
\"order\": {
        \"timestamp\": -1
    },
\"start\": 0,
\"limit\": 1
}
" >10.txt

#最终比对合适的摄像头id(不能重复)
if curl --header "session_id: 127096891@wuhanshizhedt_1563622360" -d '@10.txt'  http://100.119.30.20:11180/business/api/condition/query_camera |grep "OK" &>/dev/null 
then
 if ! grep $line {21这台机子的摄像头的id列表文件}
 then
 echo $line >>合适摄像头id.txt
 fi
fi
#echo $line >> ipzz.txt;fi
#sed -rn '/camera_ids/s#(.*\[")(.*)#\1$line"\]#'p 10.txt >kxl.txt
#sed -rn "/camera_ids/c "camera_ids": ["\$line"]"p 10.txt >kxl.txt
done < <(cat 7.txt | egrep -o "[0-9]{1,}")

#wait 
#最终比对合适的摄像头id(筛选有小问题需优化)
#diff -c {21这台机子的摄像头的id列表文件} ipzz.txt | egrep '^[-!] [0-9]{1,}' | egrep -o "[0-9]{1,}" >合适摄像头id.txt
