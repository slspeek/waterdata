#!/usr/bin/env bash
set -e
source ./waterdata_env.sh
source ./waterdata_utilities.sh

TODAY=$1
OLD_DATA=$2

LAST_DATE_FROM_OLD_DATA=$(head -2 $OLD_DATA|tail -1|cut -d' ' -f1|sed -e 's/-//g')
echo $LAST_DATE_FROM_OLD_DATA
RETRIEVED_DATA=$(mktemp)
download_waterdata $LAST_DATE_FROM_OLD_DATA $TODAY >  $RETRIEVED_DATA
merge_data $OLD_DATA $RETRIEVED_DATA 

