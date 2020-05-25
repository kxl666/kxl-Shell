#!/bin/bash
cat  <<EOF
        Physics Maths   Biology English History
Amit    85      71      61      91      81
Rahul   86      72      62      92      82
Shyam   86      73      63      93      83
Kedar   88      74      64      94      85
Hari    89      75      65      95      85
EOF



#__________________________________________________

cat > ~/test.txt <<EOF
        Physics Maths   Biology English History
Amit    85      71      61      91      81
Rahul   86      72      62      92      82
Shyam   86      73      63      93      83
Kedar   88      74      64      94      84
Hari    89      75      65      95      85
EOF
## --------------------------------------------
## 行列置换：显示<Amit同学>的<各科成绩>
## while
echo 
read -e -p "name:" NAME
#awk 'BEGIN{n1=1; split("Physics Maths Biology English History",className); printf "%-10s%-10s\n","'$NAME'","成绩"}
#     /'$NAME'/{
#               while(n1<NF)
#               {
#                printf "%-10s",className[n1]
#                printf "%-10s\n",$((n1+1))
#                n1=n1+1
#               }
#               #n1=1
#              }
#     END {print "结束"}' ~/test.txt

## for
awk 'BEGIN{split("Physics Maths Biology English History",className); printf "%-10s%-10s\n","'$NAME'","成绩"}
     /'$NAME'/{
               for(n1=1; n1<NF; ++n1)
               {
                printf "%-10s",className[n1]
                printf "%-10s\n",$((n1+1))
               }
              }
     END {print "结束"}' ~/test.txt

wait 
rm -rf  ~/test.txt
