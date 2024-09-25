#!/usr/bin/env bash
set -e
source ./env.sh
source ./utilities.sh

## Update grondwater peil data
cd ${1}

TODAY_ISO=${2}
TODAY=$TODAY_ISO
TWODAGO=$(twodays_before $TODAY)

download_waterdata $TWODAGO $TODAY > grondwaterpeildatatemp.csv
merge_data grondwaterpeildata.csv grondwaterpeildatatemp.csv

download_neerslagdata $TWODAGO $TODAY > neerslaggrtemp.csv
merge_data neerslaggr.csv neerslaggrtemp.csv

mkdir -p website
## Maak grafiek
docker run -u $(id -u):$(id -g)  --rm -v$PWD:/project -w/project slspeek/r-plotly Rscript grafiek.R

## upload
## upload command ##
