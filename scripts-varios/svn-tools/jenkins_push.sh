#!/bin/bash

REPOS="$1"
REV="$2"

UUID=`svnlook uuid $REPOS`
/usr/bin/wget \
  --header "Content-Type:text/plain;charset=UTF-8" \
  --post-data "`svnlook changed --revision $REV $REPOS`" \
  --output-document "-" \
  --timeout=2 \
  http://server/subversion/${UUID}/notifyCommit?rev=$REV
