#!/bin/zsh
R_MIN=1000
R_MAX=9999
COLS=2
COUNT=10

if [[ $1 =~ '^-+h' ]]; then
   echo "USAGE:"
   echo "  $0 MIN MAX COUNT COLS"
   echo ""
   echo "If you specify an option then all preceding options MUST be specified"
   echo "DEFAULTS:"
   echo "    MIN=${R_MIN}"
   echo "    MAX=${R_MAX}"
   echo "  COUNT=${COUNT}"
   echo "   COLS=${COLS}"
   return 1
fi

# Parse options:
#  rnd MIN MAX COUNT COLS
if [ $# -ge 1 ]; then R_MIN=$1; fi
if [ $# -ge 2 ]; then R_MAX=$2; fi
if [ $# -ge 3 ]; then COUNT=$3; fi
if [ $# -ge 4 ]; then  COLS=$4; fi

echo "Contacting RANDOM.ORG to generate ${COUNT} random numbers ${R_MIN}..${R_MAX}, please wait...."
curl "https://www.random.org/integers/?num=${COUNT}&min=${R_MIN}&max=${R_MAX}&col=${COLS}&base=10&format=plain&rnd=new"
