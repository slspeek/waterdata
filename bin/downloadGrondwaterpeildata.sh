#!/usr/bin/env sh
set -e

. ./utilities.sh

TODAY=$1

download_waterdata $START_DATE $TODAY >  grondwaterpeildata.csv

TWODAGO=$(twodays_before $TODAY)

download_waterdata $TWODAGO $TODAY >  grondwaterpeildatatemp.csv

merge_data grondwaterpeildata.csv grondwaterpeildatatemp.csv

