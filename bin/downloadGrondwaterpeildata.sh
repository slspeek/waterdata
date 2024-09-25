#!/usr/bin/env bash
set -e

source ./utilities.sh

TODAY=$1

download_waterdata $START_DATE $TODAY >  grondwaterpeildata.csv
# cp grondwaterpeildata.csv  grondwaterpeildata.csv.before

# #FIXME Why is this done? Test to see difference
# TWODAGO=$(twodays_before $TODAY)

# download_waterdata $TWODAGO $TODAY >  grondwaterpeildatatemp.csv

# merge_data grondwaterpeildata.csv grondwaterpeildatatemp.csv

