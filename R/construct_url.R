construct_url <- function(searchTerm,
                          searchType = "bacdive_id") {
  URLencode(paste0(
    "https://bacdive.dsmz.de/api/bacdive/",
    searchType,
    "/",
    searchTerm,
    "/"
  ))
}
