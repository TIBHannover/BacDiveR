All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased

### Added

-

### Deprecated
### Removed
### Security
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

- An error in the download of a single dataset found through it's culture collection number (see #45)

### Added

- Usable example / vignette in the README.md file (see #16)
