#!/usr/bin/env bash
set -e
source ./waterdata_env.sh
source ./waterdata_utilities.sh

TODAY=$1

OLD_DATA=$2
FROM_DATE=$(tail -1 $OLD_DATA |cut -d' ' -f1|sed -e 's/-//g')
download_waterdata $FROM_DATE $TODAY >  grondwaterpeildata.csv
merge_data grondwaterpeildata.csv $OLD_DATA
cp grondwaterpeildata.csv $OLD_DATA

