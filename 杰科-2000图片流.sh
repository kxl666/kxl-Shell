#!/bin/bash
rm -rf newcamera_list 

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
if curl --header "session_id: 1164888804@wuhanshizhedt_1563622360" -d '@10.txt'  http://100.119.30.20:11180/business/api/condition/query_camera |grep "OK" &>/dev/null 
then

#最终比对合适的摄像头id 
 if ! grep $line camera_list.txt
 then
  echo $line >> newcamera_list 
 fi

fi

done < <(cat 7.txt | egrep -o "[0-9]{1,}")

