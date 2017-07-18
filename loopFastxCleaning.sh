FILES=`cat LIST | xargs`


for i in $FILES
do 

        echo $i
        bsub -J $i -oo $i.oe -eo $i.oe "./FastxCleaning.sh $i Logs"     

done 
