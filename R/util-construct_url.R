#' Construct URLs of API searches
#'
#' @inheritParams retrieve_data
#' @keywords internal
construct_url <- function(searchTerm,
                          searchType = "bacdive_id") {
  searchTerm <- sanitise_input(searchTerm, searchType)

  return(utils::URLencode(
    paste0(
      "https://bacdive.dsmz.de/api/bacdive/",
      searchType,
      "/",
      searchTerm,
      "/",
      "?format=json"
    )
  ))
}
