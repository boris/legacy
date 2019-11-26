#!/bin/bash
# This is a script for lazy people, like me. Used when I've to whois an IP but I only know the domain.
DOMAIN=$@
CMD=`dig $@ | grep IN | awk '{print $5}'`
echo "domain to query: " $@
echo ""
for i in $CMD
do
	echo -e "IP:  \t\t"$i
	whois $i | grep descr
	whois $i | grep country
	echo ""
done
