all: check site

check:
	Rscript -e "devtools::check()"

docu:
	Rscript -e "devtools::document()"

site:
	Rscript -e "pkgdown::build_site()"

# vignettes: docu
#	Rscript -e "lapply(list.files(path = 'vignettes', pattern = '*.Rmd', full.names = TRUE), knitr::knit"
