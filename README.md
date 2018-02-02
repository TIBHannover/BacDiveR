# BacDiveR

Programmatic interface for the [Bacterial Diversity Metadatabase](https://bacdive.dsmz.de/) of the [DSMZ](https://www.dsmz.de/about-us.html) (German Collection of Microorganisms and Cell Cultures / Deutsche Sammlung von Mikroorganismen und Zellkulturen GmbH; Leibniz Institut).

[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](http://www.repostatus.org/badges/latest/wip.svg)](http://www.repostatus.org/#wip)

## Installation

1. in any R console, run the following command: `if (!"devtools" %in% installed.packages()) install.packages("devtools"); devtools::install_github("katrinleinweber/BacDiveR")`
1. run `file.edit(BacDiverR:::get_Renviron_path())`,
2. add your BacDive email and password directly after the `=`,
3. save the file and either a) run `readRenviron(BacDiverR:::get_Renviron_path())`, or b) restart R(Studio).

## References

> Carola Söhngen, Adam Podstawka, Boyke Bunk, Dorothea Gleim, Anna Vetcininova,
> Lorenz Christian Reimer, Christian Ebeling, Cezar Pendarovski, Jörg Overmann;
> BacDive – The Bacterial Diversity Metadatabase in 2016, 
> [Nucleic Acids Research, Volume 44, Issue D1, 4 January 2016, Pages D581–D585](https://academic.oup.com/nar/article/44/D1/D581/2503137), 
> [doi:10.1093/nar/gkv983](https://doi.org/10.1093/nar/gkv983)

## Assumptions in the code. If you disagree with any of them, please [raise a constructive issue](https://github.com/katrinleinweber/BacDiveR/issues/new).

- taxons (genus, species & subspecies names) do not contain numbers
- accession / sequence numbers and culture collection numbers can be distinguished with [regular expressions](https://github.com/katrinleinweber/BacDiveR/blob/master/R/guess_searchType.R)

