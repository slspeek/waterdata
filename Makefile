WORKING_DIR=$(shell pwd)/build

default: clean view

clean:
	rm -rfv build

install_deps:
	sudo apt update
	sudo apt install r-base r-base-dev
	sudo apt install build-essential  libxml2-dev libssl-dev libcurl4-openssl-dev
	sudo R -q -e "install.packages(c('curl'))"
	sudo R -q -e "install.packages('plotly')"

prepare: 
	mkdir -p build
	cp *.sh *.R build
	sed -i -e 's|/home/tobias/waterdata|$(WORKING_DIR)|g' build/*.sh build/*.R

.ONESHELL:
setup: prepare
	cd $(WORKING_DIR)
	bash downloadGrondwaterpeildata.sh
	bash downloadNeerslagdata.sh

.ONESHELL:
test: setup
	cd $(WORKING_DIR)
	bash waterdata_cron.sh

.ONESHELL:
zip: test
	cd $(WORKING_DIR)
	zip -r resultaat.zip test.html lib
	
.ONESHELL:
view: test
	cd $(WORKING_DIR)
	x-www-browser test.html

lintr:
	R -q -e "library(lintr);lint(filename = 'grafiek.R')"

print:
	echo $(WORKING_DIR);

