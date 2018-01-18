# BacDiveR

Programmatic interface for the [Bacterial Diversity Metadatabase](https://bacdive.dsmz.de/) of the [DSMZ](https://www.dsmz.de/about-us.html) (German Collection of Microorganisms and Cell Cultures / Deutsche Sammlung von Mikroorganismen und Zellkulturen GmbH; Leibniz Institut).

[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](http://www.repostatus.org/badges/latest/wip.svg)](http://www.repostatus.org/#wip)


## Installation

Please note: The [BacDive API requires registration](https://bacdive.dsmz.de/api/bacdive/registration/register/), which is a manual process on both ends. Best do that first, and wait with the installation until you have your login credentials.

1. in any R console, run the following command: `if (!"devtools" %in% installed.packages()) install.packages("devtools"); devtools::install_github("katrinleinweber/BacDiveR")`
1. in R, load the package with `library("BacDiveR")`
1. run `file.edit(BacDiverR::get_Renviron_path())`,
2. add your BacDive email and password directly after the `=`,
3. save the file and either a) run `readRenviron(BacDiverR::get_Renviron_path())`, or b) restart R(Studio).


## First steps (or "How to become a BacDiveR")

BacDiveR primarily provides one high-level function:
[`retrieve_data()`](/blob/master/R/retrieve_data.R). Try using it with simply a  
`searchTerm = "…"` of your interest. 

1. For example: `Bss <- retrieve_data("Bacillus subtilis subtilis")` 
   should return a vector of numbers. These are the BacDive IDs of all entries 
   within that taxonomic group. This is useful for meta-analyses of groups.

1. If you want to data-mine the taxon, use:
   
> (Bss_data <- retrieve_data("Bacillus subtilis subtilis", force_taxon_download = TRUE))

1. If you know exactly, which dataset you need, specify this by providing an 
   umambiguous `searchTerm` and its `searchType`, like:

> (retrieve_data(searchTerm = "DSM 319", searchType = "culturecollectionno"))

Please learn more via `?retrieve_data`.


## References

> Carola Söhngen, Adam Podstawka, Boyke Bunk, Dorothea Gleim, Anna Vetcininova,
> Lorenz Christian Reimer, Christian Ebeling, Cezar Pendarovski, Jörg Overmann;
> BacDive – The Bacterial Diversity Metadatabase in 2016, 
> [Nucleic Acids Research, Volume 44, Issue D1, 4 January 2016, Pages D581–D585](https://academic.oup.com/nar/article/44/D1/D581/2503137), 
> [doi:10.1093/nar/gkv983](https://doi.org/10.1093/nar/gkv983)


## Assumptions in the code…

… are [marked by `[ ] assume` as comments](https://github.com/katrinleinweber/BacDiveR/search?q=assume&type=Code). If you disagree with any of them, please [raise a constructive issue](https://github.com/katrinleinweber/BacDiveR/issues/new).
