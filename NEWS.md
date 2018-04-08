# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## Unreleased

### Added

- `retrieve_search_results()`, see #61

### Changed

- `retrieve_data()` now download the dataset(s) by default, not only the ID(s), see #59 

## [0.4.0] - 2018-03-27

### Added

- This changelog (see #41)

### Changed

- Datasets in the aggregated (large) list are now named according to their 
`bacdive_ID`s (see #47). Before, the list were only numbered with `1`, `2`, `3`,
etc.

## [0.3.1] - 2018-03-24

### Fixed

- An error in the download of a single dataset found through it's culture collection number (see #45)

### Added

- Usable example / vignette in the README.md file (see #16)

