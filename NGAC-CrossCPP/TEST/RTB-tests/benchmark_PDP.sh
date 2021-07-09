i=0
# -lt is less than operator

while [ $i -lt 100 ]
do
    sh location_PDP.sh 
    i=`expr $i + 1`
done