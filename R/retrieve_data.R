#' Retrieve data from BacDive
#'
#' @param searchTerm Mandatory character string (in case of the `searchType`
#'   `sequence`, `culturecollectionno` or `taxon`) or integer (in case of
#'   `bacdive_id`), specifying what shall be searched for.
#'
#' @param searchType Mandatory character string that specifies which type of
#'   search will be performed (technically, which API endpoint). Can be `taxon`
#'   (default), `bacdive_id`, `sequence`, or `culturecollectionno`.
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
#'   an unambiguous search, and may cause R(Studio) to become temporarily
#'   unresponsive. Maybe go for a walk for a few minutes ;-)
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
#' @examples retrieve_data(searchTerm = "Bacillus subtilis subtilis")
#'   # This returns a numeric vector of IDs. To download all the corresponding
#'   # data, use:
#'   retrieve_data("Bacillus subtilis subtilis", force_taxon_download = TRUE)
#'
#'   # In case the `searchTerm` is unambiguous already, the data download will
#'   # procede automatically:
#'   retrieve_data(searchTerm = "DSM 319", searchType = "culturecollectionno")
#'   retrieve_data(searchTerm = "AJ000733", searchType = "sequence")
#'   retrieve_data(searchTerm = 717, searchType = "bacdive_id")
retrieve_data <- function(searchTerm,
                          searchType = "taxon",
                          force_taxon_download = FALSE) {

  x <-
    jsonlite::fromJSON(download(construct_url(searchTerm, searchType)))

  if (force_taxon_download &&
      !is.null(x$count) && x$count > 100)
    warn_slow_download(x$count)

  if (identical(names(x), c("count", "next", "previous", "results")) &&
      !force_taxon_download) {
    return(aggregate_result_IDs(x))

  } else if (identical(names(x), c("count", "next", "previous", "results")) &&
             force_taxon_download) {
    taxon_data <- list()
    URLs <- aggregate_result_URLs(x)
    IDs <- URLs_to_IDs(URLs)
    message("Data download in progress for BacDive-IDs: ", appendLF = FALSE)
    for (i in seq(length(URLs))) {
      message(IDs[i], " ", appendLF = FALSE)
      taxon_data[i] <- download(paste0(URLs[i], "?format=json"))
    }
    taxon_data <- lapply(taxon_data, jsonlite::fromJSON)
    names(taxon_data) <- IDs
    return(taxon_data)

  } else if (is.list(x) && length(x) == 1) {
    # repeat download, if API returned a single ID, instead of a full dataset
    x <- jsonlite::fromJSON(download(paste0(x[1]$url, "?format=json")))
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
  gsub(
    pattern = "[[:space:]]+",
    replacement = " ",
    perl = TRUE,
    # Prevent "lexical error: invalid character inside string."
    # https://github.com/jeroen/jsonlite/issues/47
  RCurl::getURL(
    URL,
    userpwd = userpwd,
    httpauth = 1L
    )
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
  while (TRUE) {
    URLs <- c(URLs, unlist(results$results, use.names = FALSE))
    if (!is.null(results$`next`))
      results <- jsonlite::fromJSON(download(results$`next`))
    else break
  }
  return(URLs)
}


URLs_to_IDs <- function(URLs) {
  gsub(pattern = "\\D", "", URLs)
}
