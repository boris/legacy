#!/bin/bash                                                                                                                                                                                            
date=`date +%Y%m%d`                                                                                                                                                                                     
dbuser=<local DB user>
ruser=<remote user>                                                                                                                                                                                        
rhost=<remote host>                                                                                                                                                                                 
rdir=<remote dir>                                                                                                                                                          
dbs=(db1 db2 dbN template0 template1 templateN)


for i in ${dbs[*]}
do
      pg_dump -U $dbuser -Z 5 -f postgres_${i}_$date.gz ${i}
      scp postgres_${i}_$date.gz $ruser@$rhost:$rdir
      rm postgres_${i}_$date.gz
done

