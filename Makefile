SHELL=/bin/bash
WORKING_DIR=$(shell pwd)/build
TODAY=20240923

default: clean view

clean:
	rm -rfv build

prepare: 
	mkdir -p build
	cp bin/*.sh bin/*.R build

.ONESHELL:
setup: prepare
	cd $(WORKING_DIR)
	source env.sh
	bash downloadGrondwaterpeildata.sh $(TODAY)
	bash downloadNeerslagdata.sh $(TODAY)

.ONESHELL:
test: setup
	cd $(WORKING_DIR)
	# source env.sh
	bash waterdata_cron.sh $(WORKING_DIR) $(TODAY)

.ONESHELL:
view: test
	cd $(WORKING_DIR)
	x-www-browser website/index.html

lintr:
	R -q -e "library(lintr);lint(filename = 'grafiek.R')"

