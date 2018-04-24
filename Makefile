all: check site

	Rscript -e "devtools::check(document = FALSE)"
check:

docu:
	Rscript -e "devtools::document(); roxygen2::roxygenise()"

site: vignettes
	Rscript -e "pkgdown::build_site()"

vignettes: docu
	Rscript -e "knitr::knit(list.files(path = "vignettes", pattern = "*.Rmd$", full.names = TRUE))"
