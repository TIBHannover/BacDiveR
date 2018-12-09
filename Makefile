all: check site

spell:
	Rscript -e "spelling::spell_check_package()"

check: spell
	Rscript -e "devtools::check()"

docu: spell
	Rscript -e "devtools::document()"

install:
	Rscript -e "devtools::install()"

site: install docu
	Rscript -e "pkgdown::build_site(document = FALSE)"
	htmlproofer --allow_hash_href --http_status_ignore=403 docs/
	git update-index --assume-unchanged docs/articles/BacDive-ing-in_files/figure-html/ggplot-1.png

cov:
	Rscript -e "covr::package_coverage()"

# vignettes: docu
#	Rscript -e "lapply(list.files(path = 'vignettes', pattern = '*.Rmd', full.names = TRUE), knitr::knit"
