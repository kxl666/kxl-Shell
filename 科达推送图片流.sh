#!/bin/bash
rm -rf newcamera_list02 

#获取session_id
cat >1.txt <<eof
{
        "name": "admin",
        "password": "32f818906e760f0205ed174c90f6f739"
}
eof

a=` curl -d '@1.txt' http://100.119.30.20:11180/business/api/login | egrep -o "\"[0-9].*" | sed -rn 's/(")(.*)("})/\2/'p ` 

#获取所有摄像头id
curl --location --request GET 'http://100.119.30.20:11180/business/api/camera?predecessor_id=2&depth=5' --header "session_id: $a" | egrep -o "\"id\":\"[0-9]{1,}"  >7.txt
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
b1=` curl --header "session_id: $a" -d '@10.txt'  http://100.119.30.20:11180/business/api/condition/query_camera | egrep -o "timestamp\":[0-9]{1,}" | egrep -o "[0-9]{1,}" `

if date -d "@$b1" | grep "2020年 10月 29日" 
then

#最终比对合适的摄像头id 
if ! grep $line camera_list.txt
then
echo $line >> newcamera_list02
fi

fi

done < <(cat 7.txt | egrep -o "[0-9]{1,}")

