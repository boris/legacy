#!/bin/bash
log='/tmp/log.txt'
subject='EMAIL SUBJECT'
email='you@email.com'
cat $log |mail -s $subject $email
rm $log
