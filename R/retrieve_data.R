#' Retrieve data from BacDive
#'
#' @param searchTerm Mandatory character string (in case of `searchType = `
#'   `sequence`, `culturecollectionno` or `taxon`) or integer (in case of
#'   `bacdive_id`), specifying what shall be searched for.
#'
#' @param searchType Mandatory character string that specifies which type of
#'   search will be performed (technically, which API endpoint). Can be `taxon`
#'   (default), `bacdive_id`, `sequence`, or `culturecollectionno`.
#'
#' @return A list of lists containing either a single BacDive dataset in case
#'   the `searchTerm` was unambiguous (`bacdive_id`, `sequence`,
#'   `culturecollectionno`), or a large list containing all datasets that match
#'   an ambiguous `searchTerm` (most `taxon`s).
#'
#' @export
#' @examples retrieve_data(searchTerm = "Bacillus subtilis subtilis")
#'   # This returns a numeric vector of IDs. To download all the corresponding
#'   # data, use:
#'   retrieve_data("Bacillus subtilis subtilis")
#'
#'   # In case the `searchTerm` is unambiguous already, the data download will
#'   # procede automatically:
#'   retrieve_data(searchTerm = "DSM 319", searchType = "culturecollectionno")
#'   retrieve_data(searchTerm = "AJ000733", searchType = "sequence")
#'   retrieve_data(searchTerm = 717, searchType = "bacdive_id")
retrieve_data <- function(searchTerm,
                          searchType = "taxon") {
  payload <-
    jsonlite::fromJSON(download(construct_url(searchTerm, searchType)))



  if (identical(payload$detail, "Not found"))
  {
    stop(
      "Your search returned no result, sorry. Please make sure that you provided a searchTerm, and specified the correct searchType. Please type '?retrieve_data' and read through the 'searchType' section to learn more."
    )
  }
  else if (is_dataset(payload))
  {
    return(payload)
  }
  else
  {
    if (!is.null(payload$count) && payload$count > 100) warn_slow_download(payload$count)
    aggregate_datasets(payload)
  }
}


aggregate_datasets <- function(payload)
{
  URLs <- aggregate_result_URLs(payload)
  IDs <- URLs_to_IDs(URLs)
  message("Data download in progress for BacDive-IDs: ", appendLF = FALSE)

  taxon_data <- list()
  for (i in seq(length(URLs))) {
    message(IDs[i], " ", appendLF = FALSE)
    taxon_data[i] <- download(paste0(URLs[i], "?format=json"))
  }
  taxon_data <- lapply(taxon_data, jsonlite::fromJSON)
  names(taxon_data) <- IDs
  return(taxon_data)
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

  if (length(results$url) == 1)
    return(results$url)

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

is_dataset <- function(payload) {
  identical(
    names(payload),
    c("taxonomy_name",
      "morphology_physiology",
      "culture_growth_condition",
      "environment_sampling_isolation_source",
      "application_interaction",
      "molecular_biology",
      "strain_availability",
      "references")
    )
}
