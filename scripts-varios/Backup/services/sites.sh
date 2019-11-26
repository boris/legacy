#!/bin/bash
log='/tmp/log.txt'
s3cmd sync /var/www/ s3://<backup>/folder/ >> $log
