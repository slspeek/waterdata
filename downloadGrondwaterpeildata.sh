#!/usr/bin/env sh
set -e

. ./utilities.sh

DATE=$(date +%d-%m-%Y)
START_DATE="24-09-2022"

download_waterdata $START_DATE $DATE >  grondwaterpeildata.csv

DATE=$(date +%d-%m-%Y)
TWODAGO=$(date --date="2 days ago" +%d-%m-%Y)

download_waterdata $TWODAGO $DATE >  grondwaterpeildatatemp.csv

merge_data grondwaterpeildata.csv grondwaterpeildatatemp.csv

