#!/usr/bin/env bash
set -e
source ./waterdata_utilities.sh

TODAY=$1

download_neerslagdata $START_DATE $TODAY > neerslaggr.csv