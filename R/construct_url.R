#' Construct URLs of API searches
#'
#' @inheritParams retrieve_data
construct_url <- function(searchTerm,
                          searchType = "bacdive_id",
                          force = FALSE) {

  searchTerm <- sanitise_input(searchTerm, searchType)

  if (!force)
    searchType <- guess_searchType(searchTerm, searchType)

  URLencode(
    paste0(
      "https://bacdive.dsmz.de/api/bacdive/",
      searchType,
      "/",
      searchTerm,
      "/?format=json"
    )
  )
}
