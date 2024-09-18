#!/usr/bin/env bash

DATE=$(date +%Y%m%d)
curl -d 'start=20220924&end='$DATE'&vars=RH&stns=350' https://www.daggegevens.knmi.nl/klimatologie/daggegevens > neerslaggrtemp.csv
tail -n+9 neerslaggrtemp.csv > neerslaggr.csv
