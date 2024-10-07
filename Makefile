SHELL=/bin/bash
WORKING_DIR=$(shell pwd)/build
TODAY=$(shell date +%Y%m%d)
WATERDATA_HOME=$(shell pwd)

default: clean view

clean:
	rm -rfv build

prepare:
	mkdir -p build
	cp bin/*.sh bin/*.R build


.ONESHELL:
update_grondwaterpeildata: prepare
	cd $(WORKING_DIR)
	./update_grondwaterpeildata.sh $(TODAY) $(WATERDATA_HOME)/resource/archive/grondwaterdata/grondwaterpeildata.csv

.ONESHELL:
graph: prepare lintr
	cd $(WORKING_DIR)
	export WATERDATA_HOME=$(WATERDATA_HOME)
	./waterdata_cron.sh $(WORKING_DIR) $(TODAY)

.ONESHELL:
view: graph
	cd $(WORKING_DIR)
	x-www-browser website/index.html

lintr:
	docker run -u $(id -u):$(id -g)  --rm -v$$PWD:/project -w/project slspeek/lintr \
		Rscript -e "errors <- lintr::lint('bin/grafiek.R'); print(errors); quit(save = 'no', status = length(errors))"

