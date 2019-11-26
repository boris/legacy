#!/bin/bash
date=`date +%Y%m%d`
delete=`date +%Y%m%d -d"5 days ago"`
user='user'
pass='password'
rdir='s3://' #DO NOT Forget the ending /
dbs=('db1' 'db2' 'dbN')
log='/tmp/log.txt'

echo " " >> $log
echo "MySQL Backup" >> $log
echo "------------" >> $log
for db in ${dbs[@]}
do
     mysqldump -u $user -p$pass ${db} > $date'_'$db.sql
     s3cmd put $date'_'$db.sql $rdir >> $log
     rm $date'_'$db.sql
done

for db in ${dbs[@]}
do
   s3cmd del $rdir/$delete'_'$db.sql
   echo "$delete'_'$db.sql DELETED" >> $log
done
