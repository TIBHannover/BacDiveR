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
#' @examples
#'   \donttest{dataset_717 <- retrieve_data(searchTerm = 717, searchType = "bacdive_id")}
#'   \donttest{dataset_DSM_319 <- retrieve_data(searchTerm = "DSM 319", searchType = "culturecollectionno")}
#'   \donttest{dataset_AJ000733 <- retrieve_data(searchTerm = "AJ000733", searchType = "sequence")}
#'   \donttest{dataset_Bss <- retrieve_data(searchTerm = "Bacillus subtilis subtilis")}
retrieve_data <- function(searchTerm,
                          searchType = "taxon")
  {
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
    payload <- list(payload)
    names(payload) <- searchTerm
    return(payload)
  }
  else if (!is.null(payload$count))
  {
    if (payload$count > 100)
      warn_slow_download(payload$count)

    aggregate_datasets(payload)
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
download <-
  function(URL,
           userpwd = paste(get_credentials(), collapse = ":"))
  {
    message(URLs_to_IDs(URL), " ", appendLF = FALSE)

    RCurl::getURL(URL,
                  userpwd = userpwd,
                  httpauth = 1L)
  }


is_dataset <- function(payload)
{
  identical(
    names(payload),
    c(
      "taxonomy_name",
      "morphology_physiology",
      "culture_growth_condition",
      "environment_sampling_isolation_source",
      "application_interaction",
      "molecular_biology",
      "strain_availability",
      "references"
    )
  )
}
