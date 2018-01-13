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
#'   single BacDive datase,
#'   OR (from a _am_biguous searchTerm) a numeric vector of BacDive-IDs, which
#'   can be fed back into `retrieve_data()` to retrieve the individual data
#'   sets.
#'
#' @export
#' @examples retrieve_data(searchTerm = 717)
#'   retrieve_data(searchTerm = "AJ000733", searchType = "sequence")
#'   retrieve_data(searchTerm = "DSM 319", "culturecollectionno")
#'   retrieve_data("Bacillus subtilis subtilis", searchType = "taxon")
retrieve_data <- function(searchTerm,
                          searchType = "bacdive_id",
                          force = FALSE) {
  x <-
    rjson::fromJSON(download(construct_url(searchTerm, searchType, force)))

  if (identical(names(x), c("count", "next", "previous", "results"))) {

    IDs <- aggregate_result_IDs(x$results)

    # r <- 1
    # while (r < ceil...)
    for (r in seq(1, ceiling(x$count/100))) {
      x$`next` %>%
        download() %>%
        rjson::fromJSON() ->
        x

      aggregate_result_IDs(x$results) %>%
        c(IDs, .) ->
        IDs
      return(IDs)
    }
    # r <- r+1
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

download <- function(URL, userpwd = paste(get_credentials(), collapse = ":")) {
  RCurl::getURL(
    URL,
    userpwd = userpwd,
    httpauth = 1L
  )
}

aggregate_result_IDs <- function(results) {
  results %>%
    unlist() %>%
    strsplit("/") %>%
    sapply(., function(x) x[7]) %>%
    as.numeric()
}
