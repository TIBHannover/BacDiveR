all: check site

spell:
	Rscript -e "spelling::spell_check_package()"

check: spell
	Rscript -e "devtools::check()"

docu: spell
	Rscript -e "devtools::document()"

install:
	Rscript -e "devtools::install()"

cov:
	Rscript -e "covr::package_coverage()"

# vignettes: docu
#	Rscript -e "lapply(list.files(path = 'vignettes', pattern = '*.Rmd', full.names = TRUE), knitr::knit"
