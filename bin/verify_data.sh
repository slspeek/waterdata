#!/usr/bin/env bash
set -e

for HOUR in {00..23}
do
  TIME="$HOUR:00:00"
  # echo Time: $TIME
  echo -n $TIME " ";cat $1 |grep "$TIME" |wc -l
done
