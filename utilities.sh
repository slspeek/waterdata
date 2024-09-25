#!/usr/bin/env bash
set -e

ELLITRACK_DATE_FORMAT=%d-%m-%Y
KNMI_DATE_FORMAT=%Y%m%d

function twodays_before() {
    date --date="$1 -2 days" +%Y%m%d
}

function ellitrack_login() {
    curl --location \
         --cookie-jar cookies.txt \
         --data-urlencode "username=$ET_USERNAME" \
         --data-urlencode "password=$ET_PASSWORD" \
         --data "submit=Log+in" https://www.ellitrack.nl/auth/login &> /dev/null
}

function ellitrack_date() {
    date --date $1 +"$ELLITRACK_DATE_FORMAT"
}

function download_waterdata() {
    ellitrack_login
    FROM_DATE=$(ellitrack_date $1)
    TO_DATE=$(ellitrack_date $2)
    curl --cookie cookies.txt \
         --cookie-jar cookies.txt \
         "https://www.ellitrack.nl/multitracker/downloadexport/trackerid/${ET_TRACKERID}/\
type/period/n/0/periodfrom/${FROM_DATE}%2012%3A00/\
periodto/${TO_DATE}%2012%3A00/periodtype/date"
}

function knmi_date() {
    date --date $1 +"$KNMI_DATE_FORMAT"
}

function download_neerslagdata() {
    FROM_DATE=$(knmi_date $1)
    TO_DATE=$(knmi_date $2)
    curl --data "start=$FROM_DATE" \
         --data "end=$TO_DATE" \
         --data "vars=RH" \
         --data "stns=$KNMI_STATION_CODE" https://www.daggegevens.knmi.nl/klimatologie/daggegevens | \
    tail -n+9
}

function merge_data() {
    TEMPFILE=$(mktemp)
    cat $1 > $TEMPFILE
    tail -n+2 $2 >> $TEMPFILE
    {
        head -n1 $TEMPFILE; 
        tail -n+2 $TEMPFILE | sort -u;
    } > $1
}