[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)


# BacDiveR

This R package provides a programmatic interface for the [Bacterial
Diversity Metadatabase][BD] ([Söhngen et al. 2014 & 2016
](#references)) of the [DSMZ (German Collection of Microorganisms and Cell Cultures)][DMSZ].
BacDiveR helps you to conduct your microbial
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

3.  After installing, follow the instructions on the console to save your login
    credentials locally and restart R(Studio) or run:

In the examples and vignettes, the data retrieval will only work if your login credentials are correct in themselves (no typos) and were correctly saved. Console output like `"{\"detail\": \"Invalid username/password\"}"`, or `Error: $ operator is invalid for atomic vectors` mean that either the login credentials or the `.Renviron` file are incorrect. In that case, please run:

``` r
file.edit(file.path(Sys.getenv('HOME'), '.Renviron'))
```

and make sure it contains the following:

    BacDive_email=your.email@provider.org
    BacDive_password=YOUR_20_char_password


## How to use

There are two main functions. Please click on their names to read their docu: 
[`retrieve_data()`][r_d] and [`retrieve_search_results()`][r_s_r].
For real-life examples, please read the vignettes ["BacDive-ing in"][dive-in] 
and about the ["Semi-automatic approach"][adv-search].

[r_d]: https://tibhannover.github.io/BacDiveR/reference/retrieve_data.html
[r_s_r]: https://tibhannover.github.io/BacDiveR/reference/retrieve_search_results.html
[dive-in]: https://tibhannover.github.io/BacDiveR/articles/BacDive-ing-in.html
[adv-search]: https://tibhannover.github.io/BacDiveR/articles/advanced-search.html


## Known issues: see [bugs] and [ADR]s

[ADR]: https://github.com/TIBHannover/BacDiveR/tree/master/docs/arch
[bugs]: https://github.com/tibhannover/BacDiveR/issues?q=is%3Aissue+is%3Aopen+label%3Abug+sort%3Aupdated-desc


## Similar tools

- [@cjm007's `BacDive_` (Python)](https://github.com/cjm007/BacDive_)
- [@zorino's `microbe-dbs` (Python & Shell)](https://github.com/zorino/microbe-dbs)


# References

- Söhngen, Carola, Boyke Bunk, Adam Podstawka, Dorothea Gleim, and Jörg
  Overmann. 2014. “BacDive—the Bacterial Diversity Metadatabase.” *Nucleic
  Acids Research* 42 (D1): D592–D599.
  [doi:10.1093/nar/gkt1058](https://doi.org/10.1093/nar/gkt1058).

- Söhngen, Carola, Adam Podstawka, Boyke Bunk, Dorothea Gleim, Anna
  Vetcininova, Lorenz Christian Reimer, Christian Ebeling, Cezar
  Pendarovski, and Jörg Overmann. 2016. “BacDive – the Bacterial Diversity
  Metadatabase in 2016.” *Nucleic Acids Research* 44 (D1): D581–D585.
  [doi:10.1093/nar/gkv983](https://doi.org/10.1093/nar/gkv983).
