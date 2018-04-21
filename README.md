[![Project Status: WIP – Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](http://www.repostatus.org/badges/latest/wip.svg)](http://www.repostatus.org/#wip)


# BacDiveR

This R package provides a programmatic interface for the [Bacterial
Diversity Metadatabase][BD] ([Söhngen et al. 2014 & 2016
](#references)) of the [DSMZ (German Collection of Microorganisms and Cell Cultures)
][DMSZ]. BacDiveR helps you to conduct your 
research better and faster, by:

- downloading the BacDive datasets you want to investigate off-line, and by

- providing you with a way to document and report your searches and downloads, 
  in a reproducible manner (`.R` scripts and/or `.Rmd` files).


[BD]: https://bacdive.dsmz.de/
[DMSZ]: https://www.dsmz.de/about-us.html
[reg]: https://bacdive.dsmz.de/api/bacdive/registration/register/


## Installation

1.  Because the [BacDive API requires registration][reg] please do that first 
    and wait for your access to be granted.

2.  Once you have your login credentials, install BacDiveR from GitHub
    with:

``` r
# install.packages("devtools")
devtools::install_github("tibhannover/BacDiveR")
```

3.  After installing, run the following commands to save your login
    credentials locally:

``` r
file.edit(BacDiveR:::get_Renviron_path())
```

4.  In that file, add your email and password directly after the `=`
    signs, save it, then restart R(Studio) or run:

``` r
readRenviron(BacDiveR:::get_Renviron_path())
```
In the following examples, the data retrieval will only work if your login credentials are correct in themselves (no typos) and were correctly saved. Console output like `"{\"detail\": \"Invalid username/password\"}"`, or `Error: $ operator is invalid for atomic vectors` mean that either the login credentials or the `.Renviron` file are incorrect. Please repeat steps 2 to 4.


## How to use

There are two main functions. Please click on their names to read their docu: 
[`retrieve_data()`][r_d] and [`retrieve_search_results()`][r_s_r].

For more details, please see the vignettes:

1. ["BacDive-ing in"][dive-in]
1. ["Semi-automatic approach"][adv-search]

[r_d]: https://tibhannover.github.io/BacDiveR/reference/retrieve_data.html
[r_s_r]: https://tibhannover.github.io/BacDiveR/reference/retrieve_search_results.html
[dive-in]: https://tibhannover.github.io/BacDiveR/articles/BacDive-ing-in.html
[adv-search]: https://tibhannover.github.io/BacDiveR/articles/advanced-search.html


# References

- Söhngen, Carola, Boyke Bunk, Adam Podstawka, Dorothea Gleim, and Jörg
  Overmann. 2014. “BacDive—the Bacterial Diversity Metadatabase.” *Nucleic
  Acids Research* 42 (D1): D592–D599.
  doi:[10.1093/nar/gkt1058](https://doi.org/10.1093/nar/gkt1058).

- Söhngen, Carola, Adam Podstawka, Boyke Bunk, Dorothea Gleim, Anna
  Vetcininova, Lorenz Christian Reimer, Christian Ebeling, Cezar
  Pendarovski, and Jörg Overmann. 2016. “BacDive – the Bacterial Diversity
  Metadatabase in 2016.” *Nucleic Acids Research* 44 (D1): D581–D585.
  doi:[10.1093/nar/gkv983](https://doi.org/10.1093/nar/gkv983).
