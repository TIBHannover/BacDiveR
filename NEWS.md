All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased

### Added
### Changed
### Deprecated
### Removed
### Fixed
### Security

# BacDiveR 0.6.0

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
  spaces occured)! Thus, if you are parsing BacDiveR output in any way, you may
  need to adjust that. Because I consider this unlikely given the "maturing" status,
  and because no API surface was changed, I don't consider this a major change
  in the [SemVer.org](https://semver.org/) sense.
  

## BacDiveR 0.4.2

### Fixed

- Install errors are now warnings and better advise about fixing them (#62)


## BacDiveR 0.4.1

### Changed

- Don't run all function docu examples, and limit their output on the 
  [reference](https://tibhannover.github.io/BacDiveR/reference/retrieve_data.html) 
  [pages](https://tibhannover.github.io/BacDiveR/reference/retrieve_search_results.html)
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
