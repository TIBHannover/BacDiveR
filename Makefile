all: check site

check:
	Rscript -e "devtools::check()"

docu:
	Rscript -e "devtools::document(); codemetar::write_codemeta()"

site:
	Rscript -e "pkgdown::build_site()"

# vignettes: docu
#	Rscript -e "lapply(list.files(path = 'vignettes', pattern = '*.Rmd', full.names = TRUE), knitr::knit"
