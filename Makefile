WORKING_DIR=$(shell pwd)/build

default: clean view

clean:
	rm -rfv build

prepare: 
	mkdir -p build
	cp *.sh *.R build

.ONESHELL:
setup: prepare
	cd $(WORKING_DIR)
	bash downloadGrondwaterpeildata.sh
	bash downloadNeerslagdata.sh

.ONESHELL:
test: setup
	cd $(WORKING_DIR)
	bash waterdata_cron.sh $$PWD

.ONESHELL:
view: test
	cd $(WORKING_DIR)
	x-www-browser website/test.html

lintr:
	R -q -e "library(lintr);lint(filename = 'grafiek.R')"

