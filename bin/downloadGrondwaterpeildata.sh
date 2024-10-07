#!/usr/bin/env bash
set -e

source ./waterdata_utilities.sh

TODAY=$1

download_waterdata $START_DATE $TODAY >  grondwaterpeildata.csv
