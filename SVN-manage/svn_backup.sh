#!/bin/bash
date=`date +%Y%m%d`
ruser=<remote user>
rhost=<server>
rdir=<remote dir to backup>
repo=(repo1 repo2 repo3 repoN)

#create a dump of each SVN in 'repo' array
for i in ${repo[*]}
do
   svnadmin dump /opt/svn/${i} > ${i}_$date.dump

   #send the file to the backup server
   scp ${i}_$date.dump $ruser@$rhost:$rdir
   if [ $? -gt 0 ]
   then
      echo "Error while sending backup file to remote server"
   else
      #remove the file to save space on the 
      rm ${i}_$date.dump
   fi
done
