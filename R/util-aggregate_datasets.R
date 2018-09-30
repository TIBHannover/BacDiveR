aggregate_datasets <- function(payload, from_IDs = FALSE) {
  if (from_IDs) {
    warn_slow_download(length(payload))
    IDs <- payload
    URLs <- purrr::map_chr(.x = IDs, .f = construct_url)
  }
  else {
    warn_slow_download(payload$count)
    URLs <- aggregate_result_URLs(payload)
    IDs <- URLs_to_IDs(URLs)
  }

  message(paste0(
    "Downloading BacDive IDs (",
    min(as.integer(IDs)),
    " to ",
    max(as.integer(IDs)),
    ", but not necessarily contiguous): "
  ))
  taxon_data <-
    purrr::map(.x = purrr::map(URLs, download), .f = jsonlite::fromJSON)
  names(taxon_data) <- IDs

  taxon_data
}


#' Aggregate BacDive-URLs from a Paged List of Retrieved URLs
#'
#' @param results A list of paginated URLs returned by an ambiguous
#'   `searchTerm` in `retrieve_data()`.
#'
#' @return An integer vector of all BacDive URLs within the results.
#' @keywords internal
aggregate_result_URLs <- function(results) {
  URLs <- list()
  while (TRUE) {
    URLs <- append(URLs, unlist(results$results, use.names = FALSE))
    if (!is.null(results$`next`)) {
      results <- jsonlite::fromJSON(download(results$`next`))
    } else {
      break
    }
  }
  paste0(URLs, "?format=json")
}


URLs_to_IDs <- function(URLs)
  gsub(pattern = "\\D", "", URLs)
