#' Construct URLs of API searches
#'
#' @inheritParams retrieve_data
construct_url <- function(searchTerm,
                          searchType = "bacdive_id",
                          force = FALSE) {

  searchTerm <- sanitise_input(searchTerm, searchType)

  if (!force) {
    guessed <- guess_searchType(searchTerm, searchType)
    searchTerm <- guessed[1]
    searchType <- guessed[2]
  }

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
