#' Construct URLs of API searches
#'
#' @param searchTerm Mandatory character string (in case of `bacdive_id`
#'   (default), `sequence`, `culturecollectionno` or `taxon` `searchType`)  or
#'   integer (in case of `bacdive_id`), specifying what shall be search for.
#' @param searchType Mandatory character string that specifies which type of
#'   search will be performed (technically, which API endpoint). Can be
#'   `bacdive_id` (default), `sequence`, `culturecollectionno` or `taxon`.
#'
#' @inherit utils::URLencode return
#'
#' @examples construct_url(717)
#'   construct_url("AF12345", searchType = "sequence")
#'   construct_url("DSM 319", searchType = "culturecollectionno")
#'   construct_url("Pseudomonas", searchType = "taxon")
#'   construct_url("Bacillus subtilis subtilis", searchType = "taxon")
construct_url <- function(searchTerm,
                          searchType = "bacdive_id") {
  # reconstruct taxon search from "Genus species subspecies" input, or
  # hierarchical part thereof
  if (searchType == "taxon") {
    searchTerm <- paste(collapse = "/",
                        # paste0() or paste(sep = "/", …) not useful here,
                        # because list items aren't themselves pasted together.
                        strsplit(searchTerm, " ")[[1]])
  }

  URLencode(paste0(
    "https://bacdive.dsmz.de/api/bacdive/",
    searchType,
    "/",
    searchTerm,
    "/"
  ))
}
