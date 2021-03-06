% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bd_retrieve_by_search.R
\name{bd_retrieve_by_search}
\alias{bd_retrieve_by_search}
\title{Retrieve the Results of an Advanced Search}
\usage{
bd_retrieve_by_search(queryURL)
}
\arguments{
\item{queryURL}{Mandatory character string. URL the search results page.}
}
\value{
A (large) list containing either a single BacDive dataset in case
your parameter / search was unambiguous, or if ambiguous: all matching datasets.
Read \href{https://bacdive.dsmz.de/api/bacdive/}{BacDive.DSMZ.de/api/bacdive}
to learn more.
}
\description{
\href{https://bacdive.dsmz.de/advsearch}{BacDive.DSMZ.de/AdvSearch} returns a
list of results, which you can retrieve in bulk via the URL of the results
page. Please see the \href{https://tibhannover.github.io/BacDiveR/articles/pre-configuring-advanced-searches-and-retrieving-the-results.html#mass-downloading-datasets}{vignette "Pre-Configuring Advanced Searches and Retrieving the Results"}.
}
\examples{
plant_animal_pathogens <-
  bd_retrieve_by_search(
    queryURL = paste(
      "https://bacdive.dsmz.de/advsearch?site=advsearchsearch",
      "params\%5B5\%5D\%5Bsearchterm\%5D=1",
      "searchparams\%5B157\%5D\%5Bsearchterm\%5D=1",
      "searchparams\%5B158\%5D\%5Bsearchterm\%5D=1",
      "advsearch=search",
      sep = "&"
    )
  )
}
