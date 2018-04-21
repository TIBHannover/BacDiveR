all: docu vignettes site

check: docu
	Rscript -e "devtools::check(document = FALSE)"

docu: vignettes
	Rscript -e "devtools::document(); roxygen2::roxygenise()"

site: docu
	Rscript -e "pkgdown::build_site()"

vignettes:
	Rscript -e "knitr::knit(list.files(path = "vignettes", pattern = "*.Rmd$", full.names = TRUE))"
