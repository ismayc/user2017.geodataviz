.PHONY: build clean

RMD_FILES=$(shell find inst -name '*.Rmd')
HTML_FILES=$(RMD_FILES:%.Rmd=%.html)
CACHE_DIRS=$(RMD_FILES:%.Rmd=%_cache)
FIGURE_DIRS=$(RMD_FILES:%.Rmd=%_files)

RENDER = Rscript -e "suppressMessages(library(rmarkdown)); render('$<', quiet=TRUE)"

%.html: %.Rmd
	@echo "\033[35m$< ==> $@\033[0m"
	$(RENDER)

build: build.done

build.done: $(HTML_FILES)
	@echo "\033[35mBuilding Package\033[0m"
	Rscript -e 'devtools::install(upgrade_dependencies=F)'
	touch $@

docker:

clean:
	@echo "\033[35mCleaning ...\033[0m"
	rm -rf build.done $(HTML_FILES) $(CACHE_DIRS) $(FIGURE_DIRS)
