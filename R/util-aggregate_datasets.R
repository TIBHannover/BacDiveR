aggregate_datasets <- function(payload, from_IDs = FALSE) {
  if (from_IDs) {
    warn_slow_download(length(payload))
    IDs <- payload
    URLs <- lapply(X = IDs, FUN = construct_url)
  }
  else {
    warn_slow_download(payload$count)
    URLs <- aggregate_result_URLs(payload)
    IDs <- URLs_to_IDs(URLs)
  }

  message(
    "Downloading BacDive IDs ",
    min(as.integer(IDs)),
    " to ",
    max(as.integer(IDs)),
    " (but not necessarily contiguously): "
  )
  taxon_data <- lapply(X = URLs, download)
  names(taxon_data) <- IDs

  taxon_data
}


#' Aggregate BacDive-URLs from a Paged List of Retrieved URLs
#'
#' @param results A list of paginated URLs returned by an ambiguous
#'   `bd_retrieve_…()` call.
#'
#' @return An integer vector of all BacDive URLs within the results.
#' @keywords internal
aggregate_result_URLs <- function(results) {
  URLs <- list()
  while (TRUE) {
    URLs <- append(URLs, unlist(results$results, use.names = FALSE))
    if (!is.null(results$`next`)) {
      results <- download(results$`next`)
    } else {
      break
    }
  }
  paste0(URLs, "?format=json")
}


URLs_to_IDs <- function(URLs)
  gsub(pattern = "\\D", "", URLs)
