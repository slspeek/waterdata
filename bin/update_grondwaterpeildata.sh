#!/usr/bin/env bash
set -e
source ./waterdata_env.sh
source ./waterdata_utilities.sh

TODAY=$1
OLD_DATA=$2

if [ -z "$3" ]; then
  LAST_DATE_FROM_OLD_DATA=$(head -2 $OLD_DATA|tail -1|cut -d' ' -f1|sed -e 's/-//g')
  FROM_DATE=$(date --date "$LAST_DATE_FROM_OLD_DATA -1 days" +%Y%m%d)
else
  FROM_DATE=$3
fi

RETRIEVED_DATA=$(mktemp)
echo Downloading waterdata from $FROM_DATE to $TODAY
download_waterdata $FROM_DATE $TODAY >  $RETRIEVED_DATA
merge_data $OLD_DATA $RETRIEVED_DATA 

