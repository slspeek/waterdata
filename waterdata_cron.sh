#!/usr/bin/env bash
set -e
. ./utilities.sh

PTH='/home/tobias/waterdata'
## Update grondwater peil data
cd $PTH

DATE=$(date +%d-%m-%Y)
TWODAGO=$(date --date="2 days ago" +%d-%m-%Y)
download_waterdata $TWODAGO $DATE > grondwaterpeildatatemp.csv
merge_data grondwaterpeildata.csv grondwaterpeildatatemp.csv

## update neerslag data
curl -d 'start='$TWODAGO'&end='$DATE'&vars=RH&stns=350' https://www.daggegevens.knmi.nl/klimatologie/daggegevens > neerslaggrtemp.csv
# tail -n+10 $PTH/neerslaggrtemp.csv >> $PTH/neerslaggr.csv
# { head -n1 $PTH/neerslaggr.csv; tail -n+2 $PTH/neerslaggr.csv | sort -u;} > $PTH/file.tmp && mv $PTH/file.tmp $PTH/neerslaggr.csv
merge_data neerslaggr.csv neerslaggrtemp.csv

## Maak grafiek
docker run -u $(id -u):$(id -g)  --rm -v$PWD:/project -w/project slspeek/r-plotly Rscript grafiek.R

## upload
## upload command ##
