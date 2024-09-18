#!/usr/bin/env bash
set -e

function ellitrack_login() {
    curl -L --cookie-jar cookies.txt \
         --data-urlencode "username=$EL_USERNAME" \
         --data-urlencode "password=$EL_PASSWORD" \
         --data "submit=Log+in" https://www.ellitrack.nl/auth/login &> /dev/null
}

function download_waterdata() {
    ellitrack_login
    curl -b cookies.txt \
         -c cookies.txt \
         "https://www.ellitrack.nl/multitracker/downloadexport/trackerid/23688/\
type/period/n/0/periodfrom/${1}%2012%3A00/\
periodto/${2}%2012%3A00/periodtype/date"
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