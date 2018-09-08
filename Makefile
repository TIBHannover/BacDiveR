all: check site

spell:
	Rscript -e "spelling::spell_check_package()"

check: spell
	Rscript -e "devtools::check()"

docu: spell
	Rscript -e "devtools::document()"

site: docu
	Rscript -e "devtools::install(); pkgdown::build_site(document = FALSE)"

# vignettes: docu
#	Rscript -e "lapply(list.files(path = 'vignettes', pattern = '*.Rmd', full.names = TRUE), knitr::knit"
