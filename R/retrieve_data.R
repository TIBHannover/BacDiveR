#' Retrieve data from BacDive
#'
#' @param searchTerm Mandatory character string (in case of `sequence`,
#'   `culturecollectionno` or `taxon` `searchType`)  or integer (in case of
#'   `bacdive_id`), specifying what shall be searched for.
#' @param searchType Mandatory character string that specifies which type of
#'   search will be performed (technically, which API endpoint). Can be
#'   `bacdive_id` (default), `sequence`, `culturecollectionno` or `taxon`.
#' @param force Logical. Whether or not the searchType should be enforced
#'   strictly, even if it appears to mismatch the searchTerm. Please note:
#'   forcing an apparently mismatched searchType will most likely result in an
#'   error: `retrieve_data(searchTerm = "AJ000733", searchType = "bacdive_id",
#'   force = TRUE)` without specifying `searchType = "sequence"` should lead to
#'   an internal re-specification, and execution of the intended search.
#'
#' @return EITHER (from an unambiguous searchTerm) a list of lists containing a
#'   single BacDive dataset,
#'   OR (from a _am_biguous searchTerm) a numeric vector of BacDive-IDs, which
#'   can be fed back into `retrieve_data()` to retrieve the individual data
#'   sets.
#'
#' @export
#' @examples retrieve_data(searchTerm = 717)
#'   retrieve_data(searchTerm = "AJ000733", searchType = "sequence")
#'   retrieve_data(searchTerm = "DSM 319", "culturecollectionno")
#'   retrieve_data("Bacillus subtilis", searchType = "taxon")
retrieve_data <- function(searchTerm,
                          searchType = "bacdive_id",
                          force = FALSE) {

  searchTerm <- sanitise_input(searchTerm, searchType)

  if (!force)
    searchType <- guess_searchType(searchTerm, searchType)

  x <- rjson::fromJSON(download(utils::URLencode(
    paste0(
      "https://bacdive.dsmz.de/api/bacdive/",
      searchType,
      "/",
      searchTerm,
      "/?format=json"
    )
  )))

  if (identical(names(x), c("count", "next", "previous", "results"))) {

    IDs <- aggregate_result_IDs(x$results)

    # extract IDs from all pages
    # quoting necessary, because it's an R base::Control keyword :-/
    `next` <- x$`next`
    while (!is.null(`next`)) {
      x <- rjson::fromJSON(download(`next`))
      IDs <- c(IDs, aggregate_result_IDs(x$results))
      `next` <- x$`next`
    }
    return(IDs)
  } else if (is.list(x) && length(x) == 1) {
    # repeat download, if API returned a single ID, instead of a full dataset
    x <- rjson::fromJSON(download(paste0(x[[1]][1]$url, "?format=json")))
    return(x)
  } else if (identical(x$detail, "Not found")) {
    stop(
      "Your search returned no result, sorry. Please make sure that you provided a searchTerm, and specified the correct searchType. Please type '?retrieve_data' and read through the 'searchType' section to learn more."
    )
  } else {
    return(x)
  }
}


#' Download Something from BacDive
#'
#' @param URL represented by a correctly encoded character string with spaces,
#'   thanks to utils::URLencode.
#' @param userpwd A character string of the format
#'   `BacDive_email:BacDive_password`. Retrieved from .Renviron my default, but
#'   also used with something else by the tests.
#'
#' @inherit RCurl getURL return
download <- function(URL, userpwd = paste(get_credentials(), collapse = ":")) {
  RCurl::getURL(
    URL,
    userpwd = userpwd,
    httpauth = 1L
  )
}


#' Aggregate BacDive IDs from a List of Retrieved URLs
#'
#' @param results A list of paginated URLs resulting from an ambigous
#'   `searchTerm` in `retrieve_data()`
#'
#' @return An integer vector of all BacDive IDs within the results.
aggregate_result_IDs <- function(results) {
  as.numeric(sapply(strsplit(
    x = unlist(results), split = "/"
  ), function(x)
    x[7]))
  # IDs the 7th part in the URls resulting from an ambiguous searchTerm
  # e.g. https://bacdive.dsmz.de/api/bacdive/bacdive_id/138982/
  # => [1] "https:"          ""                "bacdive.dsmz.de" "api"
  # => [5] "bacdive"         "bacdive_id"      "138982
}
