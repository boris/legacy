#!/bin/bash
date=`date +%Y%m%d`
ruser=<remote user>
rhost=<remote host>
rdir=<remote path>
dbs=(col1 col2 colN)

for i in ${dbs[*]}
do
      mongodump -d ${i} -o ${i}_dump
      tar czf mongo_${i}_$date.tar.gz ${i}_dump
      rm -rf ${i}_dump
      scp mongo_${i}_$date.tar.gz $ruser@$rhost:$rdir
      
      rm mongo_${i}_$date.tar.gz
done

