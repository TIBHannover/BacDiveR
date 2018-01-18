#' Construct URLs of API searches
#'
#' @inheritParams retrieve_data
construct_url <- function(searchTerm,
                          searchType = "bacdive_id",
                          force_search = FALSE) {
  if (!force_search)
    searchType <- guess_searchType(searchTerm, searchType)

  searchTerm <- sanitise_input(searchTerm, searchType)

  utils::URLencode(
    paste0(
      "https://bacdive.dsmz.de/api/bacdive/",
      searchType,
      "/",
      searchTerm,
      "/?format=json"
    )
  )
}
