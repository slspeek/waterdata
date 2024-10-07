#!/usr/bin/env bash
set -e

mkdir -p website
docker run -u $(id -u):$(id -g)  --rm -v$PWD:/project -w/project slspeek/r-plotly Rscript grafiek.R "$@"
