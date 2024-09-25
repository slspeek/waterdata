#!/usr/bin/env bash
set -e

TODAY=$1

source ./env.sh
source ./utilities.sh
./downloadNeerslagdata.sh $TODAY
./downloadGrondwaterpeildata.sh $TODAY
merge_data grondwaterpeildata.csv $WATERDATA_HOME/resource/archive/grondwaterdata/grondwaterpeildata.csv

