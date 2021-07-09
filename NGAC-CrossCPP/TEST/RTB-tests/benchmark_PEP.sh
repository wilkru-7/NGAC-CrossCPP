i=0
# -lt is less than operator

while [ $i -lt 100 ]
do
    sh location_PEP.sh &
    sh location_PEP.sh &
    sh location_PEP.sh 
    i=`expr $i + 1`
done
