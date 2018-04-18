#' Construct URLs of API searches
#'
#' @inheritParams retrieve_data
#' @examples
#'   construct_url(searchTerm = 717)
#'   construct_url("AJ000733", searchType = "sequence")
#'   construct_url("DSM 319", searchType = "culturecollectionno")
#'   construct_url("Bacillus subtilis spizizenii", searchType = "taxon")
construct_url <- function(searchTerm,
                          searchType = "bacdive_id") {

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
