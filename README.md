# BacDiveR [![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing) [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1308060.svg)](https://zenodo.org/record/1308060)

This R package provides a programmatic interface to the [Bacterial Diversity Metadatabase][BD] of the [DSMZ (German Collection of Microorganisms and Cell Cultures)][DMSZ]. BacDiveR helps you improve your research on bacteria and archaea by providing access to "structured information on [...] their taxonomy, morphology, physiology, cultivation, geographic origin, application, interaction" and more ([Söhngen et al. 2016](#references)). Specifically, you can:

- download the BacDive data you need for offline investigation, and

- document your searchers and downloads in `.R` scripts, `.Rmd` files, etc.

Thus, BacDiveR can be the basis for a reproducible data analysis pipeline. See [TIBHannover.GitHub.io/BacDiveR][page] for more details, [/news] there for the changelog, and [GitHub.com/TIBHannover/BacDiveR][source] for the latest source code.

It was also built to serve as a demonstration object during [TIB's "FAIR Data & Software" workshop][FDS].

[BD]: https://bacdive.dsmz.de/
[DMSZ]: https://www.dsmz.de/about-us.html
[FDS]: https://tibhannover.github.io/2018-07-09-FAIR-Data-and-Software/#schedule
[/news]: https://tibhannover.github.io/BacDiveR/news/index.html
[page]: https://tibhannover.github.io/BacDiveR/
[reg]: https://bacdive.dsmz.de/api/bacdive/registration/register/
[source]: https://github.com/TIBHannover/BacDiveR/
[releases]: https://github.com/TIBHannover/BacDiveR/releases/latest

<!-- Paste the above section into the release description
together with the latest section of `NEWS.md` in order to usefully populate Zenodo.
Afterwards, remove the above from GitHub. -->

## Installation

1.  Because the [BacDive API requires registration][reg] please do that first 
    and wait for DSMZ staff to grant you access.

2.  Once you have your login credentials, install the [latest BacDiveR release][releases]
    from GitHub with:

``` r
if(!require('devtools')) install.packages('devtools')
devtools::install_github('TIBHannover/BacDiveR', ref = 'v0.7.0')
# Please omit the `ref` only if you want to test the latest development version!
```

3.  After installing, follow the instructions on the console to save your login
    credentials locally and restart R(Studio) or run:

``` r
file.edit(file.path(Sys.getenv('HOME'), '.Renviron'))
```

and make sure it contains the following:

    BacDive_email=your.email@provider.org
    BacDive_password=YOUR_20_char_password

In the examples and vignettes, the data retrieval will only work if your login credentials are correct in themselves (no typos) _and_ were correctly saved. Console output like `"{\"detail\": \"Invalid username/password\"}"`, or `Error: $ operator is invalid for atomic vectors` indicates that either the login credentials are incorrect, or the `.Renviron` file.


## How to use

There are two main functions: [`retrieve_data()`][r_d] and [`retrieve_search_results()`][r_s_r].
Please click on their names to read their docu, and find real-life examples in
the vignettes ["BacDive-ing in"][dive-in] and ["Pre-Configuring Advanced Searches"][adv-search].

[r_d]: https://tibhannover.github.io/BacDiveR/reference/retrieve_data.html
[r_s_r]: https://tibhannover.github.io/BacDiveR/reference/retrieve_search_results.html
[dive-in]: https://tibhannover.github.io/BacDiveR/articles/BacDive-ing-in.html
[adv-search]: https://tibhannover.github.io/BacDiveR/articles/advanced-search.html


## How to cite

Best execute `citation('BacDiveR')` in the R console and use its output because that
ensures you are citing exactly the installed version. You can also use the `Cite as`
or `Export` options presented on [Zenodo.org/record/1308060][zenodo]. If you want
to import [this GitHub repo's metadata][GH] into a reference manager directly, I
recommend [Zotero] and its [GitHub translator][zotGH]. When using BibTeX, you might
want to try changing the item type from to `@Software` ;-)
[Support for that is being worked on](https://github.com/FORCE11/FORCE11-sciwg).

Don't forget to also [cite BacDive itself](https://bacdive.dsmz.de/about) whenever
you used their data, regardless of access method.


## Known issues: see [bugs] and [ADR]s

[ADR]: https://github.com/TIBHannover/BacDiveR/tree/master/vignettes
[bugs]: https://github.com/tibhannover/BacDiveR/issues?q=is%3Aissue+is%3Aopen+label%3Abug+sort%3Aupdated-desc
[GH]: https://github.com/TIBHannover/BacDiveR/
[zenodo]: https://zenodo.org/record/1308060#invenio-csl
[zotero]: https://www.zotero.org/
[zotGH]: https://github.com/zotero/translators/blob/master/Github.js


## Similar tools

These seem to scrape **all** data, instead of retrieving specific datasets.

- @cjm007's [`BacDive_`](https://github.com/cjm007/BacDive_) &
  [`BacDivePy`](https://github.com/cameronmartino/BacDivePy) (Python)
- [@zorino's `microbe-dbs` (Python & Shell)](https://github.com/zorino/microbe-dbs)
- [@EngqvistLab's Python script](https://github.com/EngqvistLab/fetch_microbial_growth_temperatures/tree/master/BacDive)
- or generally: [GitHub.com/topics/bacdive](https://github.com/topics/bacdive)

# References

- Söhngen, Bunk, Podstawka, Gleim, Overmann. 2014. “BacDive — the Bacterial
  Diversity Metadatabase.” *Nucleic Acids Research* 42 (D1): D592–D599.
  [doi:10.1093/nar/gkt1058](https://academic.oup.com/nar/article/42/D1/D592/1046203).

- Söhngen, Podstawka, Bunk, Gleim, Vetcininova, Reimer, Ebeling, Pendarovski, 
  Overmann. 2016. “BacDive – the Bacterial Diversity Metadatabase in 2016.”
  *Nucleic Acids Research* 44 (D1): D581–D585.
  [doi:10.1093/nar/gkv983](https://academic.oup.com/nar/article/44/D1/D581/2503137).

- Reimer, Vetcininova, Carbasse, Söhngen, Gleim, Ebeling, Overmann. 2018.
  “BacDive in 2019: Bacterial Phenotypic Data for High-Throughput Biodiversity
  Analysis” *Nucleic Acids Research* 
  [doi:10.1093/nar/gky879](https://academic.oup.com/nar/advance-article/5106998).
