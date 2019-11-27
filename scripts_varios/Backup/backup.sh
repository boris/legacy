#!/bin/bash
log='/tmp/log.txt'
echo "Backup start" > $log
echo "------------" >> $log

source /var/local/backup/services/mysql.sh
source /var/local/backup/services/sites.sh
source /var/local/backup/services/mail.sh
