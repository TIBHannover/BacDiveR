all: check site

check:
	Rscript -e "devtools::check()"

docu:
	Rscript -e "devtools::document(); codemetar::write_codemeta()"

site: docu
	Rscript -e "pkgdown::build_site(document = FALSE)"

# vignettes: docu
#	Rscript -e "lapply(list.files(path = 'vignettes', pattern = '*.Rmd', full.names = TRUE), knitr::knit"
