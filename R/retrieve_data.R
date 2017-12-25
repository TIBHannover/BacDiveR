#' Download a dataset from BacDive
#'
#' @param searchTerm Mandatory character string (in case of `sequence`,
#'   `culturecollectionno` or `taxon` `searchType`)  or integer (in case of
#'   `bacdive_id`), specifying what shall be searched for.
#' @param searchType Mandatory character string that specifies which type of
#'   search will be performed (technically, which API endpoint). Can be
#'   `bacdive_id` (default), `sequence`, `culturecollectionno` or `taxon`.
#'
#' @inherit rjson::fromJSON return
#'
#' @export
#' @examples retrieve_data(717)
#'   retrieve_data("AJ000733", searchType = "sequence")
#'   retrieve_data("DSM 319", searchType = "culturecollectionno")
#'   retrieve_data("Pseudomonas", searchType = "taxon")
#'   retrieve_data("Bacillus subtilis subtilis", searchType = "taxon")
retrieve_data <- function(searchTerm,
                          searchType = "bacdive_id") {
  x <-
    rjson::fromJSON(download(construct_url(searchTerm, searchType)))

  # repeat download, if API returned an ID, instead of a full dataset
  id <- x[[1]]$url
  if (!is.null(id)) {
    x <- rjson::fromJSON(download(paste0(id, "?format=json")))
  } else if (x$detail == "Not found") {
    stop(
      "Your search returned no result, sorry. Please make sure that you provided a searchTerm, and specified the correct searchType. Please type '?retrieve_data' and read through the 'searchType' section to learn more."
    )
  }

  return(x)
}

download <- function(URL) {
  RCurl::getURL(
    URL,
    userpwd = paste(BacDive_username, BacDive_password, sep = ":"),
    httpauth = 1L
  )
}
