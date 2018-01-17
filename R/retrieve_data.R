#' Retrieve data from BacDive
#'
#' @param searchTerm Mandatory character string (in case of the `searchType`
#'   `sequence`, `culturecollectionno` or `taxon`) or integer (in case of
#'   `bacdive_id`), specifying what shall be searched for.
#'
#' @param searchType Mandatory character string that specifies which type of
#'   search will be performed (technically, which API endpoint). Can be
#'   `bacdive_id` (default), `sequence`, `culturecollectionno` or `taxon`.
#'
#' @param force_search Logical; default: `FALSE`. Whether or not the searchType
#'   should be enforced strictly, even if it appears to mismatch the searchTerm.
#'   Please note: forcing an apparently mismatched searchType will most likely
#'   result in an error: `retrieve_data(searchTerm = "DSM 319", searchType =
#'   "bacdive_id", force_search = TRUE)` without specifying `searchType =
#'   "sequence"` should lead to an internal re-specification, and execution of
#'   the intended search.
#'
#' @param force_taxon_download Logical; default: `FALSE`. In case of a taxon
#'   search, BacDive will return not the actual data of the search results, but
#'   only a paged list of URLs pointing to the actual datasets. Setting
#'   `force_taxon_download = TRUE` (default: `FALSE`) triggers many downloads of
#'   the individual result datasets. Please note: This may take much longer than
#'   an unambiguous search, and may cause R(Studio) to be unresponsive
#'   temporarily Maybe go for a walk for a few minutes ;-)
#'
#' @return EITHER (from an unambiguous searchTerm, or in case of
#'   `force_taxon_download = TRUE`) a list of lists containing the single
#'   BacDive dataset for that `searchTerm`,
#'
#'   OR (from a _am_biguous search; eg.g `serchType = "taxon"`) a numeric vector
#'   of BacDive-IDs, on which you can call your own loop containing
#'   `retrieve_data()` to retrieve the individual data sets.
#'
#' @export
#' @examples retrieve_data(searchTerm = 717)
#'   retrieve_data(searchTerm = "AJ000733", searchType = "sequence")
#'   retrieve_data(searchTerm = "DSM 319", "culturecollectionno")
#'   retrieve_data("Bacillus subtilis", searchType = "taxon")
#'   retrieve_data("Bacillus subtilis subtilis", searchType = "taxon", force_taxon_download = TRUE)
retrieve_data <- function(searchTerm,
                          searchType = "bacdive_id",
                          force_search = FALSE,
                          force_taxon_download = FALSE) {

  x <-
    rjson::fromJSON(download(construct_url(searchTerm, searchType, force_search)))

  if (force_taxon_download && x$count > 100) warn_slow_download(x$count)

  if (identical(names(x), c("count", "next", "previous", "results")) &&
      !force_taxon_download) {
    return(aggregate_result_IDs(x))

  } else if (identical(names(x), c("count", "next", "previous", "results")) &&
             force_taxon_download) {
    taxon_data <- list()
    URLs <- aggregate_result_URLs(x)
    for (u in URLs) {
      taxon_data <- c(taxon_data,
                      rjson::fromJSON(download(paste0(u, "?format=json"))))
    }
    return(taxon_data)

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
#'   `BacDive_email:BacDive_password`. Retrieved from `.Renviron` my default,
#'   but also used with something else by the tests.
#'
#' @return A serialised JSON string.
download <- function(URL, userpwd = paste(get_credentials(), collapse = ":")) {
  RCurl::getURL(
    URL,
    userpwd = userpwd,
    httpauth = 1L
  )
}


#' Aggregate BacDive-IDs from a Paged List of Retrieved URLs
#'
#' @param results A list of paginated URLs returned by an ambiguous
#'   `searchTerm` in `retrieve_data()`
#'
#' @return An integer vector of all BacDive IDs within the results.
aggregate_result_IDs <- function(results) {

  IDs <- as.numeric(sapply(strsplit(
    x = aggregate_result_URLs(results), split = "/"
  ), function(x)
    x[7]))
  # IDs are the 7th part in the URls returned by an ambiguous `searchTerm`
  # e.g. https://bacdive.dsmz.de/api/bacdive/bacdive_id/138982/
  # => [1] "https:"          ""                "bacdive.dsmz.de" "api"
  # => [5] "bacdive"         "bacdive_id"      "138982

  return(IDs)
}


#' Aggregate BacDive-URLs from a Paged List of Retrieved URLs
#'
#' @param results A list of paginated URLs returned by an ambiguous
#'   `searchTerm` in `retrieve_data()`.
#'
#' @return An integer vector of all BacDive IDs within the results.
aggregate_result_URLs <- function(results) {
  URLs <- c()
  continue <- TRUE
  while (continue) {
    URLs <- c(URLs, unlist(results$results, use.names = FALSE))
    if (is.null(results$`next`)) continue <- FALSE
    else results <- rjson::fromJSON(download(results$`next`))
  }
  return(URLs)
}
