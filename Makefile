all: check site

spell:
	Rscript -e "spelling::spell_check_package()"

check: spell
	Rscript -e "devtools::check()"

docu: spell
	Rscript -e "devtools::document(); codemetar::write_codemeta()"

install:
	Rscript -e "devtools::install()"

site: install docu
	Rscript -e "pkgdown::build_site(document = FALSE)"

cov:
	Rscript -e "covr::package_coverage()"

# vignettes: docu
#	Rscript -e "lapply(list.files(path = 'vignettes', pattern = '*.Rmd', full.names = TRUE), knitr::knit"
