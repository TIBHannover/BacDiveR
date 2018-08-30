library(magrittr)

aggregate_datasets <- function(payload, from_IDs = FALSE)
{
  if (from_IDs)
  {
    IDs <- payload
    URLs <- purrr::map_chr(.x = IDs, .f = construct_url)
  }
  else
  {
    URLs <- aggregate_result_URLs(payload)
    IDs <- URLs_to_IDs(URLs)
  }

  message("Data download in progress for BacDive-IDs: ", appendLF = FALSE)

  purrr::map(.x = URLs, .f = download) %>%
    purrr::map(jsonlite::fromJSON) ->
    taxon_data
  names(taxon_data) <- IDs

  return(taxon_data)
}


#' Aggregate BacDive-URLs from a Paged List of Retrieved URLs
#'
#' @param results A list of paginated URLs returned by an ambiguous
#'   `searchTerm` in `retrieve_data()`.
#'
#' @return An integer vector of all BacDive URLs within the results.
#' @keywords internal
aggregate_result_URLs <- function(results)
{
  if (length(results$url) == 1)
    URLs <- results$url
  else
  {
    URLs <- c()
    while (TRUE) {
      URLs <- c(URLs, unlist(results$results, use.names = FALSE))
      if (!is.null(results$`next`))
        results <- jsonlite::fromJSON(download(results$`next`))
      else
        break
    }
  }
  return(paste0(URLs, "?format=json"))
}


URLs_to_IDs <- function(URLs)
  gsub(pattern = "\\D", "", URLs)
