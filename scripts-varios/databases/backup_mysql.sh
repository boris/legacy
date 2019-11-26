#!/bin/bash
#variables
date=`date +%Y%m%d`
ayer=`date +%Y%m%d -d "yesterday"`
user=<user> #de la DB
passwd=<passwd> #de la DB
ruser=<ruser> #del host remoto
rhost=<rhost> #del host remoto
rdir=<rdir> #del host remoto

mkdir /db/backup/$date
cd /db/backup/$date

for DB in `echo "show databases" | mysql -u $user -p $passwd | grep -v ^mysql$ | grep -v ^Database$`;
do
	mysqldump -u $user -p $passwd ${DB} > $date_${DB}.sql;
done

#envio a server remoto
scp *.sql $ruser@$rhost:$rdir

#elimina lo del dia anterior
rm -rf /db/backup/$ayer
