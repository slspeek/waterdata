#!/usr/bin/env bash
set -e
source ./waterdata_env.sh
source ./waterdata_utilities.sh

cd ${1}
TODAY=${2}

download_neerslagdata $START_DATE $TODAY > neerslaggr.csv

# Needed for docker
cp $WATERDATA_HOME/resource/archive/grondwaterdata/grondwaterpeildata.csv .

./draw_graph.sh grondwaterpeildata.csv neerslaggr.csv
