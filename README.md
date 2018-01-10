# BacDiveR

Programmatic interface for the [Bacterial Diversity Metadatabase](https://bacdive.dsmz.de/) of the [DSMZ](https://www.dsmz.de/about-us.html) (German Collection of Microorganisms and Cell Cultures / Deutsche Sammlung von Mikroorganismen und Zellkulturen GmbH; Leibniz Institut).

[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](http://www.repostatus.org/badges/latest/wip.svg)](http://www.repostatus.org/#wip)

## References

> BacDive - the Bacterial Diversity Metadatabase
> Söhngen C., Bunk B., Podstawka A., Gleim D., Vetcininova A., Reimer L.C., Overmann J.
> [Nucleic Acids Res. 2015](https://academic.oup.com/nar/article/44/D1/D581/2503137). 
> [doi: 10.1093/nar/gkv983](https://doi.org/10.1093/nar/gkv983). 
> Epub 2015 Sep 30. [PMID: 26424852](https://www.ncbi.nlm.nih.gov/pubmed/26424852)

## Assumptions in the code. If you disagree with any of them, please [raise a constructive issue](https://github.com/katrinleinweber/BacDiveR/issues/new).

- taxons (genus, species & subspecies names) do not contain numbers
- accession / sequence numbers and culture collection numbers can be distinguished with [regular expressions](https://github.com/katrinleinweber/BacDiveR/blob/master/R/guess_searchType.R)

