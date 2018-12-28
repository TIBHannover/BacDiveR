#' Construct URLs of Web Service searches
#'
#' @inheritParams retrieve_data
#' @keywords internal
construct_url <- function(searchTerm,
                          searchType = "bacdive_id") {
  utils::URLencode(
    paste0(
      "https://bacdive.dsmz.de/api/bacdive/",
      searchType,
      "/",
      searchTerm,
      "/",
      "?format=json"
    )
  )
}
