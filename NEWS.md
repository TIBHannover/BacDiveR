## Unreleased

### Added
### Changed
### Deprecated
### Removed
### Fixed
### Security


## BacDiveR 0.9.1

### Fixed

- Expose a previously silent download error (#110; Thanks to @jfy133!)

### Changed

- Repair outdated links in documentation
- Improve some code sections in minor ways


## BacDiveR 0.9.0

All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

### Changed

- NEW API: The deprecations announced in v0.8.0 are now completed: The
  `bd_retrieve()` family of functions has replaced `retrieve_data()` and
  `retrieve_search_results()` has been renamed to `bd_retrieve_by_search()`,
  see #96. **Please update scripts and other downstream code that use BacDiveR.**
- `purrr` is no longer an imported / required dependency, but only suggested
  due to use in the [introductory vignette], see #98.
  
[introductory vignette]: ../articles/BacDive-ing-in.html#extracting-data-fields


## BacDiveR 0.8.1

### Changed

- Warning message about no data being found is more informative now
- Documentation to follow BacDive's database updates
- Use pandoc 2.7.2 to generate the website


## BacDiveR 0.8.0

### Added

- NEW API: The `bd_retrieve()` family of functions will replace `retrieve_data()`
  soon. It consists of `bd_retrieve(id = …)`, `bd_retrieve_by_culture(collectionno = …)`,
  `bd_retrieve_by_sequence(accession = …)` and `bd_retrieve_taxon(name = …)`
  which is more auto-complete-friendly and should help avoid the internal need
  to sanitise inputs.

### Deprecated

- `retrieve_data()` has been replaced as described above.
- `retrieve_search_results()` has been renamed to `bd_retrieve_by_search()`.
- Both old functions will be removed in the next major version. Please update
  your BacDiveR-using scripts and other downstream code.


## BacDiveR 0.7.4

### Fixed

- A bug in the test suite.


## BacDiveR 0.7.3

### Changed

- Warnings, errors and message are now more concisely/informatively/strongly worded.


## BacDiveR 0.7.2

### Changed

- `retrieve_data` & `retrieve_search_results()` now validate all inputs (fix #71 & #78)


## BacDiveR 0.7.1

### Changed

- The combined use of
    a) [RCurl](https://cran.r-project.org/package=RCurl) for downloading 
       JSON-encoded data from BacDive with
    b) [jsonlite](https://cran.r-project.org/package=jsonlite) for converting the
       download into an R objects
  was plagued by some whitespace escaping problems.
  This spawned a custom repair solution, adding accidental complexity. That
  swamp is now drained by use of [httr](https://cran.r-project.org/package=httr).


## BacDiveR 0.7.0

### Added

- A [vignette section about mass-downloading datasets](https://tibhannover.github.io/BacDiveR/articles/pre-configuring-advanced-searches-and-retrieving-the-results.html#mass-downloading-datasets).

### Changed

- Instead of stopping with an error if a search returns no results, BacDiveR now
  only warns about this case and returns an empty list (#93).
- Estimated download times are now reported before all downloads longer than ca.
  30 seconds (#84).


## BacDiveR 0.6.1

### Fixed

- Errors caused by comparing against a `NULL` (#91; Thanks to @jotech!)

## BacDiveR 0.6.0

### Added

- The vignette [Logic-Checking BacDive Datasets](https://tibhannover.github.io/BacDiveR/articles/logic-checking-bacdive-datasets.html)

### Changed

- `retrieve_search_results()` now returns `NULL` when no results are found, in 
  order to ease integration of datasets into `testthat` tests.

## BacDiveR 0.5.1

### Fixed

- Another JSON whitespace escaping bug (#91; Thanks to @jotech!)

## BacDiveR 0.5.0

### Added

- Syncing of release versions to Zenodo, starting with [10.5281/zenodo.1308061](https://zenodo.org/record/1308061)

### Changed

- The JSON downloads are no longer purged of all space characters pre-emptively
  to prevent jsonlite from complaining about invalid encoding (#43). Instead, 
  only `\r`, `\n` and `\t` are repaired to `\\r`, `\\n` and `\\t`, which jsonlite
  expects. This leads to different output (newline & tabs, where previously only
  spaces occurred)! Thus, if you are parsing BacDiveR output in any way, you may
  need to adjust that. Because I consider this unlikely given the "maturing" status,
  and because no API surface was changed, I don't consider this a major change
  in the [SemVer.org](https://semver.org/) sense.
  

## BacDiveR 0.4.2

### Fixed

- Install errors are now warnings and better advise about fixing them (#62)


## BacDiveR 0.4.1

### Changed

- Don't run all function docu examples, and limit their output on the 
  [reference](https://tibhannover.github.io/BacDiveR/reference/bd_retrieve.html)
  [pages](https://tibhannover.github.io/BacDiveR/reference/bd_retrieve_by_search.html)
  (see #52)


## BacDiveR 0.4.0

### Added

- This changelog (see #41)
- `retrieve_search_results()`, see #61
- Architecture Decision records, see #53 & `/docs/arch/adr-*.md`

### Changed

- `retrieve_data()` now downloads the dataset(s) by default, not only the ID(s), see #54 & #59 
- Datasets in the aggregated (large) list are now named according to their 
`bacdive_ID`s (see #47). Before, the lists were only numbered with `1`, `2`, `3`,
etc.


## BacDiveR 0.3.1

### Fixed

- An error in the download of a single dataset found through its culture collection number (see #45)

### Added

- Usable example / vignette in the README.md file (see #16)
