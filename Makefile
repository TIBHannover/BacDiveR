all: check site

check:
	Rscript -e "devtools::check()"

docu:
	Rscript -e "devtools::document()"

site: vignettes
	Rscript -e "pkgdown::build_site()"

vignettes: docu
	Rscript -e "knitr::knit(list.files(path = "vignettes", pattern = "*.Rmd$", full.names = TRUE))"
