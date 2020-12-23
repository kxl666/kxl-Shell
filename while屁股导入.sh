while read i
do
a1=`echo $i | awk '{print $1}' `
a2=`echo $i | awk '{print $2}' `

a3=`echo $i | awk '{print $3}' `

done < <(echo "123 456 789")
echo $[$a1+$a2+$a3]
